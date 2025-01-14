#!/usr/bin/env python3
# Copyright (c) 2021-2022, NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse
from pathlib import Path

import model_navigator as nav

EXPORT_CONFIGS = {
    "distilbert-base-uncased": {
        "model_name": "distilbert-base-uncased",
        "dataset_name": "imdb",
        "padding": "max_length",
        "max_sequence_len": 384,
        "max_bs": 2,
        "sample_count": 10,
        "expected_runtimes": {
            "torchscript-trace": [nav.RuntimeProvider.PYT.value],
            "onnx": [nav.RuntimeProvider.CUDA.value],
        },
    },
    "distilgpt2": {
        "model_name": "distilgpt2",
        "dataset_name": "imdb",
        "padding": "max_length",
        "max_sequence_len": 384,
        "max_bs": 2,
        "sample_count": 10,
        "expected_runtimes": {
            "onnx": [nav.RuntimeProvider.CUDA.value],
        },
    },
}

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model-name", required=True, type=str, choices=list(EXPORT_CONFIGS.keys()))
    parser.add_argument(
        "--workdir",
        type=str,
        required=True,
    )
    args = parser.parse_args()
    model_name = args.model_name
    export_config = EXPORT_CONFIGS[model_name]
    nav_workdir = Path(args.workdir)

    nav.LOGGER.info(f"Testing {model_name}...")
    expected_runtimes = export_config.pop("expected_runtimes")
    # pytype: disable=not-callable
    pkg_desc = nav.contrib.huggingface.torch.export(
        workdir=nav_workdir,
        **export_config,
        profiler_config=nav.ProfilerConfig(measurement_request_count=20),
        runtimes=(nav.RuntimeProvider.PYT, nav.RuntimeProvider.CUDA, nav.RuntimeProvider.TRT),
        override_workdir=True,
    )
    # pytype: enable=not-callable
    nav.LOGGER.info(f"{pkg_desc.get_formats_status()=}")
    for format, runtimes_status in pkg_desc.get_formats_status().items():
        for runtime, status in runtimes_status.items():
            if runtime in expected_runtimes.get(format, {}):
                assert (
                    status == nav.Status.OK
                ), f"{format} {runtime} status is {status}, but expected runtimes are {expected_runtimes}."
            else:
                if status == nav.Status.OK:
                    nav.LOGGER.warning(f"{format} {runtime} status is {status} but it is not in expected runtimes.")
    nav.save(pkg_desc, f"{model_name}_pyt.nav")
    nav.LOGGER.info(f"{model_name} passed.")
