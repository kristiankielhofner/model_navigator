# Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.
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
import logging
import subprocess
from subprocess import CalledProcessError

from model_navigator.exceptions import ModelNavigatorException

SERVER_OUTPUT_TIMEOUT_SECS = 5
LOGGER = logging.getLogger(__name__)


class ModelAnalyzerMode:
    PROFILE = "profile"
    ANALYZE = "analyze"


class ModelAnalyzer:
    """
    Concrete Implementation of Model Analyzer interface that runs
    analyzer locally as as subprocess.
    """

    _analyzer_path = "model-analyzer"

    def __init__(self, config):
        """
        Parameters
        ----------
        path  : str
            The absolute path to the model analyzer executable
        config : AnalyzerConfig
            the config object containing arguments for this server instance
        """

        self._analyzer_process = None
        self._analyzer_config = config
        self._log = None

    def run(self, mode: str):
        """
        Starts the model analyzer locally
        """

        if self._analyzer_path:

            cmd = [self._analyzer_path, mode]
            cmd += self._analyzer_config.to_cli_string().split()

            LOGGER.debug(f"Model Analyze command: {cmd}")
            try:
                subprocess.run(cmd, check=True, start_new_session=True)

            except CalledProcessError as e:
                raise ModelNavigatorException(
                    f"Running {self._analyzer_path} with {e.cmd} failed with"
                    f" exit status {e.returncode} : {e.output}"
                )