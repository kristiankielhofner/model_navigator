# Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved.
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


class INavigatorRunner:
    @classmethod
    def is_inference_time_stabilized(cls) -> bool:
        return False


class INavigatorStabilizedRunner(INavigatorRunner):
    @classmethod
    def is_inference_time_stabilized(cls) -> bool:
        return True

    def avg_latency(self) -> float:
        raise NotImplementedError

    def std_latency(self) -> float:
        raise NotImplementedError

    def p50_latency(self) -> float:
        raise NotImplementedError

    def p90_latency(self) -> float:
        raise NotImplementedError

    def p95_latency(self) -> float:
        raise NotImplementedError

    def p99_latency(self) -> float:
        raise NotImplementedError

    def request_count(self) -> int:
        raise NotImplementedError
