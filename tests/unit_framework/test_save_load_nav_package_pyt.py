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
# pytype: disable=import-error
import os
import tempfile
from pathlib import Path
from unittest.mock import patch

import pytest
import torch
from pytest_unordered import unordered

import model_navigator as nav
from model_navigator.converter.config import TensorRTPrecision, TensorRTPrecisionMode
from model_navigator.framework_api.package_descriptor import PackageDescriptor
from model_navigator.model import Format
from model_navigator.utils.devices import get_gpus

# pytype: enable=import-error

CUDA_AVAILABLE = bool(get_gpus(["all"]))
UNAVAILABLE_FORMATS = () if CUDA_AVAILABLE else ("trt",)
UNAVAILABLE_RUNTIMES = () if CUDA_AVAILABLE else ("tensorrt", "cuda")
MN_TEST_PACKAGES_DIR_VAR_NAME = "MN_TEST_PACKAGES_DIR"


def check_model_dir(model_dir: Path, format: nav.Format, only_config: bool = False) -> bool:
    if not model_dir.is_dir():
        return False
    if not Path(model_dir / "config.yaml").is_file():
        return False
    if format == nav.Format.ONNX:
        model_path = model_dir / "model.onnx"
    elif format == nav.Format.TENSORRT:
        model_path = model_dir / "model.plan"
    else:
        model_path = model_dir / "model.pt"
    if Path(model_path).exists() == only_config:
        return False
    return True


model = torch.nn.Linear(3, 5)
dataloader = [torch.rand(2, 3)]
numpy_dataloader = [torch.rand(2, 3).numpy()]
device = "cuda" if torch.cuda.is_available() else "cpu"


def test_pyt_save_load_no_retest():
    with tempfile.TemporaryDirectory() as tmp_dir:
        model_name = "navigator_model"

        workdir = Path(tmp_dir) / "navigator_workdir"
        nav_package_path = Path(tmp_dir) / f"{model_name}.nav"

        load_workdir = Path(tmp_dir) / "load_navigator_workdir"
        status_file = load_workdir / "status.yaml"
        model_input_dir = load_workdir / "model_input"
        model_output_dir = load_workdir / "model_output"
        navigator_log_file = load_workdir / "navigator.log"

        pkg_desc = nav.torch.export(
            model=model,
            dataloader=dataloader,
            override_workdir=True,
            workdir=workdir,
            model_name=model_name,
            run_profiling=False,
            target_formats=(nav.Format.TORCHSCRIPT,),
        )

        pkg_desc.set_verified(nav.Format.TORCHSCRIPT, nav.RuntimeProvider.PYT, jit_type=nav.JitType.TRACE)
        pkg_desc.set_verified(nav.Format.TORCHSCRIPT, nav.RuntimeProvider.PYT, jit_type=nav.JitType.SCRIPT)

        nav.save(pkg_desc, nav_package_path)
        nav.load(
            nav_package_path,
            workdir=load_workdir,
            retest_conversions=False,
            run_profiling=False,
        )

        assert status_file.is_file()
        assert model_input_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_input_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert model_output_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_output_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert navigator_log_file.is_file() is False

        # Exported formats
        assert check_model_dir(model_dir=load_workdir / "torchscript-script", format=nav.Format.TORCHSCRIPT)
        assert check_model_dir(model_dir=load_workdir / "torchscript-trace", format=nav.Format.TORCHSCRIPT)


def test_pyt_save_load_retest():
    with tempfile.TemporaryDirectory() as tmp_dir:
        model_name = "navigator_model"

        workdir = Path(tmp_dir) / "navigator_workdir"
        nav_package_path = Path(tmp_dir) / f"{model_name}.nav"

        load_workdir = Path(tmp_dir) / "load_navigator_workdir"
        status_file = load_workdir / "status.yaml"
        model_input_dir = load_workdir / "model_input"
        model_output_dir = load_workdir / "model_output"
        navigator_log_file = load_workdir / "navigator.log"

        pkg_desc = nav.torch.export(
            model=model,
            dataloader=dataloader,
            override_workdir=True,
            workdir=workdir,
            model_name=model_name,
            run_profiling=False,
            target_formats=(nav.Format.TORCHSCRIPT,),
        )

        pkg_desc.set_verified(nav.Format.TORCHSCRIPT, nav.RuntimeProvider.PYT, jit_type=nav.JitType.TRACE)
        pkg_desc.set_verified(nav.Format.TORCHSCRIPT, nav.RuntimeProvider.PYT, jit_type=nav.JitType.SCRIPT)
        nav.save(pkg_desc, nav_package_path)
        nav.load(
            nav_package_path,
            workdir=load_workdir,
            run_profiling=False,
        )

        assert status_file.is_file()
        assert model_input_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_input_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert model_output_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_output_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert navigator_log_file.is_file()

        # Output formats
        assert check_model_dir(model_dir=load_workdir / "torchscript-script", format=nav.Format.TORCHSCRIPT)
        assert check_model_dir(model_dir=load_workdir / "torchscript-trace", format=nav.Format.TORCHSCRIPT)


def test_onnx_save_load_retest():
    with tempfile.TemporaryDirectory() as tmp_dir:
        model_name = "navigator_model"

        workdir = Path(tmp_dir) / "navigator_workdir"
        onnx_model_path = Path(tmp_dir) / "dummy_onnx.onnx"
        nav_package_path = Path(tmp_dir) / f"{model_name}.nav"

        load_workdir = Path(tmp_dir) / "load_navigator_workdir"
        status_file = load_workdir / "status.yaml"
        model_input_dir = load_workdir / "model_input"
        model_output_dir = load_workdir / "model_output"
        navigator_log_file = load_workdir / "navigator.log"

        torch.onnx.export(
            model.to(device),
            dataloader[0].to(device),
            onnx_model_path.as_posix(),
            opset_version=13,
            dynamic_axes={"input_0": {0: "batch"}},
            input_names=["input_0"],
        )

        if CUDA_AVAILABLE:
            runtime = nav.RuntimeProvider.CUDA
        else:
            runtime = nav.RuntimeProvider.CPU

        pkg_desc = nav.onnx.export(
            model=onnx_model_path,
            dataloader=numpy_dataloader,
            override_workdir=True,
            workdir=workdir,
            model_name=model_name,
            run_profiling=False,
            target_formats=(nav.Format.ONNX,),
            runtimes=(runtime,),
        )

        pkg_desc.set_verified(nav.Format.ONNX, runtime)
        nav.save(pkg_desc, nav_package_path)
        nav.load(
            nav_package_path,
            workdir=load_workdir,
            run_profiling=False,
        )

        assert status_file.is_file()
        assert model_input_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_input_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert model_output_dir.is_dir()
        assert all(
            [path.suffix == ".npz" for samples_dir in model_output_dir.iterdir() for path in samples_dir.iterdir()]
        )
        assert navigator_log_file.is_file()

        # Output formats
        assert check_model_dir(model_dir=load_workdir / "onnx", format=nav.Format.ONNX)


@pytest.mark.skipif(
    MN_TEST_PACKAGES_DIR_VAR_NAME not in os.environ,
    reason=f"{MN_TEST_PACKAGES_DIR_VAR_NAME} variable not found in the environment.",
)
@pytest.mark.parametrize(
    "nav_package_path",
    list((Path(os.environ.get(MN_TEST_PACKAGES_DIR_VAR_NAME)) / "pytorch").iterdir())
    if MN_TEST_PACKAGES_DIR_VAR_NAME in os.environ
    else (),
)
def test_backward_compatibility(nav_package_path: str):
    with tempfile.TemporaryDirectory() as tmp_dir:
        workdir = Path(tmp_dir) / "navigator_workdir"

        pkg_desc = nav.load(nav_package_path, workdir=workdir, retest_conversions=False)
        old_status = pkg_desc.get_formats_status()
        retest_pkg_desc = nav.load(
            nav_package_path,
            workdir=workdir,
            override_workdir=True,
            retest_conversions=False,
        )
        new_status = retest_pkg_desc.get_formats_status()

        for format, format_status in old_status.items():
            for runtime, runtime_status in format_status.items():
                if any(ft in format.lower() for ft in UNAVAILABLE_FORMATS) or any(
                    rt in runtime.lower() for rt in UNAVAILABLE_RUNTIMES
                ):
                    continue
                assert (
                    runtime_status == new_status[format][runtime]
                ), f"{format} {runtime} status not matching with the old package."


def test_use_defaults_override_conversion_parameters_for_pyt():
    with tempfile.TemporaryDirectory() as tmp_dir:
        model_name = "navigator_model"

        workdir = Path(tmp_dir) / "navigator_workdir"
        load_workdir = Path(tmp_dir) / "load_navigator_workdir"
        nav_package_path = Path(tmp_dir) / f"{model_name}.nav"

        pkg_desc = nav.torch.export(
            model=model,
            dataloader=dataloader,
            override_workdir=True,
            workdir=workdir,
            model_name=model_name,
            run_profiling=False,
            target_formats=(nav.Format.TORCHSCRIPT,),
        )
        nav.save(pkg_desc, path=nav_package_path)

        with patch.object(PackageDescriptor, "build") as mock_method, patch(
            "model_navigator.framework_api.load._copy_verified_status"
        ), patch("model_navigator.framework_api.load._copy_git_info"):
            nav.load(
                nav_package_path,
                workdir=load_workdir,
                retest_conversions=True,
                use_config_defaults=True,
            )

            assert mock_method.called

            mock_call = mock_method.mock_calls[0]
            config = mock_call.args[1]

            assert config.target_formats == (Format.TORCHSCRIPT, Format.ONNX, Format.TORCH_TRT, Format.TENSORRT)
            assert config.target_precisions == (TensorRTPrecision.FP32, TensorRTPrecision.FP16)
            assert config.precision_mode == TensorRTPrecisionMode.HIERARCHY


def test_use_defaults_override_conversion_parameters_for_onnx():
    with tempfile.TemporaryDirectory() as tmp_dir:
        model_name = "navigator_model"

        workdir = Path(tmp_dir) / "navigator_workdir"
        load_workdir = Path(tmp_dir) / "load_navigator_workdir"
        onnx_model_path = Path(tmp_dir) / "dummy_onnx.onnx"
        nav_package_path = Path(tmp_dir) / f"{model_name}.nav"

        torch.onnx.export(
            model.to(device),
            dataloader[0].to(device),
            onnx_model_path.as_posix(),
            opset_version=13,
            dynamic_axes={"input_0": {0: "batch"}},
            input_names=["input_0"],
        )

        if CUDA_AVAILABLE:
            runtime = nav.RuntimeProvider.CUDA
        else:
            runtime = nav.RuntimeProvider.CPU

        pkg_desc = nav.onnx.export(
            model=onnx_model_path,
            dataloader=numpy_dataloader,
            override_workdir=True,
            workdir=workdir,
            model_name=model_name,
            run_profiling=False,
            target_formats=(nav.Format.ONNX,),
            runtimes=(runtime,),
        )

        nav.save(pkg_desc, path=nav_package_path)

        if CUDA_AVAILABLE:
            expected_runtimes = (
                nav.RuntimeProvider.CPU,
                nav.RuntimeProvider.CUDA,
                nav.RuntimeProvider.TRT,
            )
        else:
            expected_runtimes = (nav.RuntimeProvider.CPU,)

        with patch.object(PackageDescriptor, "build") as mock_method, patch(
            "model_navigator.framework_api.load._copy_verified_status"
        ), patch("model_navigator.framework_api.load._copy_git_info"):
            nav.load(
                nav_package_path,
                workdir=load_workdir,
                retest_conversions=True,
                use_config_defaults=True,
            )

            assert mock_method.called

            mock_call = mock_method.mock_calls[0]
            config = mock_call.args[1]

            assert config.target_formats == (Format.ONNX, Format.TENSORRT)
            assert config.target_precisions == (TensorRTPrecision.FP32, TensorRTPrecision.FP16)
            assert config.precision_mode == TensorRTPrecisionMode.HIERARCHY
            assert config.runtimes == unordered(expected_runtimes)
