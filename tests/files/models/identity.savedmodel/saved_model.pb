��
�	�	
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
�
PartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring �
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring "serve*2.4.02unknown8�t

NoOpNoOp
�
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*�
value�B� B�
o
layer-0
	variables
regularization_losses
trainable_variables
	keras_api

signatures
R
	variables
regularization_losses
	trainable_variables

	keras_api
 
 
 
�
	variables

layers
regularization_losses
layer_metrics
non_trainable_variables
layer_regularization_losses
trainable_variables
metrics
 
 
 
 
�
	variables

layers
regularization_losses
layer_metrics
non_trainable_variables
layer_regularization_losses
	trainable_variables
metrics

0
 
 
 
 
 
 
 
 
 
�
serving_default_lambda_inputPlaceholder*1
_output_shapes
:�����������*
dtype0*&
shape:�����������
�
PartitionedCallPartitionedCallserving_default_lambda_input*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� **
f%R#
!__inference_signature_wrapper_139
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCallStatefulPartitionedCallsaver_filenameConst*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *%
f R
__inference__traced_save_216
�
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *(
f#R!
__inference__traced_restore_226�f
�
D
(__inference_sequential_layer_call_fn_175

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1292
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
?
__inference__wrapped_model_80
lambda_input
identityj
IdentityIdentitylambda_input*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input
�
_
C__inference_sequential_layer_call_and_return_conditional_losses_161

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
_
C__inference_sequential_layer_call_and_return_conditional_losses_165

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
C
!__inference_signature_wrapper_139
lambda_input
identity�
PartitionedCallPartitionedCalllambda_input*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *&
f!R
__inference__wrapped_model_802
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input
�
Z
>__inference_lambda_layer_call_and_return_conditional_losses_92

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
_
C__inference_sequential_layer_call_and_return_conditional_losses_119

inputs
identity�
lambda/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *G
fBR@
>__inference_lambda_layer_call_and_return_conditional_losses_882
lambda/PartitionedCall}
IdentityIdentitylambda/PartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
e
C__inference_sequential_layer_call_and_return_conditional_losses_143
lambda_input
identityj
IdentityIdentitylambda_input*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input
�
@
$__inference_lambda_layer_call_fn_188

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *G
fBR@
>__inference_lambda_layer_call_and_return_conditional_losses_882
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
J
(__inference_sequential_layer_call_fn_157
lambda_input
identity�
PartitionedCallPartitionedCalllambda_input*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1292
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input
�
E
__inference__traced_restore_226
file_prefix

identity_1��
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPH2
RestoreV2/tensor_names�
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B 2
RestoreV2/shape_and_slices�
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*
_output_shapes
:*
dtypes
22
	RestoreV29
NoOpNoOp"/device:CPU:0*
_output_shapes
 2
NoOpd
IdentityIdentityfile_prefix^NoOp"/device:CPU:0*
T0*
_output_shapes
: 2

IdentityX

Identity_1IdentityIdentity:output:0*
T0*
_output_shapes
: 2

Identity_1"!

identity_1Identity_1:output:0*
_input_shapes
: :C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�
[
?__inference_lambda_layer_call_and_return_conditional_losses_179

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
e
C__inference_sequential_layer_call_and_return_conditional_losses_147
lambda_input
identityj
IdentityIdentitylambda_input*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input
�
_
C__inference_sequential_layer_call_and_return_conditional_losses_129

inputs
identity�
lambda/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *G
fBR@
>__inference_lambda_layer_call_and_return_conditional_losses_922
lambda/PartitionedCall}
IdentityIdentitylambda/PartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
Z
>__inference_lambda_layer_call_and_return_conditional_losses_88

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
[
?__inference_lambda_layer_call_and_return_conditional_losses_183

inputs
identityd
IdentityIdentityinputs*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
i
__inference__traced_save_216
file_prefix
savev2_const

identity_1��MergeV2Checkpoints�
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*2
StaticRegexFullMatchc
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.part2
Constl
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part2	
Const_1�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: 2
Selectt

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: 2

StringJoinZ

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :2

num_shards
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 2
ShardedFilename/shard�
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 2
ShardedFilename�
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPH2
SaveV2/tensor_names�
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B 2
SaveV2/shape_and_slices�
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0savev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
22
SaveV2�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:2(
&MergeV2Checkpoints/checkpoint_prefixes�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 2
MergeV2Checkpointsr
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: 2

Identitym

Identity_1IdentityIdentity:output:0^MergeV2Checkpoints*
T0*
_output_shapes
: 2

Identity_1"!

identity_1Identity_1:output:0*
_input_shapes
: : 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:

_output_shapes
: 
�
D
(__inference_sequential_layer_call_fn_170

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1192
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
@
$__inference_lambda_layer_call_fn_193

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *G
fBR@
>__inference_lambda_layer_call_and_return_conditional_losses_922
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:Y U
1
_output_shapes
:�����������
 
_user_specified_nameinputs
�
J
(__inference_sequential_layer_call_fn_152
lambda_input
identity�
PartitionedCallPartitionedCalllambda_input*
Tin
2*
Tout
2*
_collective_manager_ids
 *1
_output_shapes
:�����������* 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *L
fGRE
C__inference_sequential_layer_call_and_return_conditional_losses_1192
PartitionedCallv
IdentityIdentityPartitionedCall:output:0*
T0*1
_output_shapes
:�����������2

Identity"
identityIdentity:output:0*0
_input_shapes
:�����������:_ [
1
_output_shapes
:�����������
&
_user_specified_namelambda_input"�J
saver_filename:0StatefulPartitionedCall:0StatefulPartitionedCall_18"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
serving_default�
O
lambda_input?
serving_default_lambda_input:0�����������<
lambda2
PartitionedCall:0�����������tensorflow/serving/predict:�B
�
layer-0
	variables
regularization_losses
trainable_variables
	keras_api

signatures
*&call_and_return_all_conditional_losses
_default_save_signature
__call__"�
_tf_keras_sequential�{"class_name": "Sequential", "name": "sequential", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "must_restore_from_config": false, "config": {"name": "sequential", "layers": [{"class_name": "InputLayer", "config": {"batch_input_shape": {"class_name": "__tuple__", "items": [null, 3, 240, 240]}, "dtype": "float32", "sparse": false, "ragged": false, "name": "lambda_input"}}, {"class_name": "Lambda", "config": {"name": "lambda", "trainable": true, "dtype": "float32", "function": {"class_name": "__tuple__", "items": ["4wEAAAAAAAAAAAAAAAEAAAABAAAAUwAAAHMEAAAAfABTACkBTqkAqQHaAXhyAQAAAHIBAAAA+jsu\nL3Rlc3RzL2ZpbGVzL21vZGVscy9wcmVwYXJlX3RmX3NhdmVkbW9kZWxfc2FtcGxlX21vZGVscy5w\nedoIPGxhbWJkYT4IAAAA8wAAAAA=\n", null, null]}, "function_type": "lambda", "module": "__main__", "output_shape": null, "output_shape_type": "raw", "output_shape_module": null, "arguments": {}}}]}, "build_input_shape": {"class_name": "TensorShape", "items": [null, 3, 240, 240]}, "is_graph_network": true, "keras_version": "2.4.0", "backend": "tensorflow", "model_config": {"class_name": "Sequential", "config": {"name": "sequential", "layers": [{"class_name": "InputLayer", "config": {"batch_input_shape": {"class_name": "__tuple__", "items": [null, 3, 240, 240]}, "dtype": "float32", "sparse": false, "ragged": false, "name": "lambda_input"}}, {"class_name": "Lambda", "config": {"name": "lambda", "trainable": true, "dtype": "float32", "function": {"class_name": "__tuple__", "items": ["4wEAAAAAAAAAAAAAAAEAAAABAAAAUwAAAHMEAAAAfABTACkBTqkAqQHaAXhyAQAAAHIBAAAA+jsu\nL3Rlc3RzL2ZpbGVzL21vZGVscy9wcmVwYXJlX3RmX3NhdmVkbW9kZWxfc2FtcGxlX21vZGVscy5w\nedoIPGxhbWJkYT4IAAAA8wAAAAA=\n", null, null]}, "function_type": "lambda", "module": "__main__", "output_shape": null, "output_shape_type": "raw", "output_shape_module": null, "arguments": {}}}]}}}
�
	variables
regularization_losses
	trainable_variables

	keras_api
*&call_and_return_all_conditional_losses
__call__"�
_tf_keras_layer�{"class_name": "Lambda", "name": "lambda", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "stateful": false, "must_restore_from_config": false, "config": {"name": "lambda", "trainable": true, "dtype": "float32", "function": {"class_name": "__tuple__", "items": ["4wEAAAAAAAAAAAAAAAEAAAABAAAAUwAAAHMEAAAAfABTACkBTqkAqQHaAXhyAQAAAHIBAAAA+jsu\nL3Rlc3RzL2ZpbGVzL21vZGVscy9wcmVwYXJlX3RmX3NhdmVkbW9kZWxfc2FtcGxlX21vZGVscy5w\nedoIPGxhbWJkYT4IAAAA8wAAAAA=\n", null, null]}, "function_type": "lambda", "module": "__main__", "output_shape": null, "output_shape_type": "raw", "output_shape_module": null, "arguments": {}}}
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
	variables

layers
regularization_losses
layer_metrics
non_trainable_variables
layer_regularization_losses
trainable_variables
metrics
__call__
_default_save_signature
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
,
serving_default"
signature_map
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
	variables

layers
regularization_losses
layer_metrics
non_trainable_variables
layer_regularization_losses
	trainable_variables
metrics
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
'
0"
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�2�
C__inference_sequential_layer_call_and_return_conditional_losses_161
C__inference_sequential_layer_call_and_return_conditional_losses_147
C__inference_sequential_layer_call_and_return_conditional_losses_165
C__inference_sequential_layer_call_and_return_conditional_losses_143�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
__inference__wrapped_model_80�
���
FullArgSpec
args� 
varargsjargs
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *5�2
0�-
lambda_input�����������
�2�
(__inference_sequential_layer_call_fn_175
(__inference_sequential_layer_call_fn_157
(__inference_sequential_layer_call_fn_152
(__inference_sequential_layer_call_fn_170�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
?__inference_lambda_layer_call_and_return_conditional_losses_183
?__inference_lambda_layer_call_and_return_conditional_losses_179�
���
FullArgSpec1
args)�&
jself
jinputs
jmask

jtraining
varargs
 
varkw
 
defaults�

 
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
$__inference_lambda_layer_call_fn_193
$__inference_lambda_layer_call_fn_188�
���
FullArgSpec1
args)�&
jself
jinputs
jmask

jtraining
varargs
 
varkw
 
defaults�

 
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�B�
!__inference_signature_wrapper_139lambda_input"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 �
__inference__wrapped_model_80|?�<
5�2
0�-
lambda_input�����������
� "9�6
4
lambda*�'
lambda������������
?__inference_lambda_layer_call_and_return_conditional_losses_179tA�>
7�4
*�'
inputs�����������

 
p
� "/�,
%�"
0�����������
� �
?__inference_lambda_layer_call_and_return_conditional_losses_183tA�>
7�4
*�'
inputs�����������

 
p 
� "/�,
%�"
0�����������
� �
$__inference_lambda_layer_call_fn_188gA�>
7�4
*�'
inputs�����������

 
p
� ""�������������
$__inference_lambda_layer_call_fn_193gA�>
7�4
*�'
inputs�����������

 
p 
� ""�������������
C__inference_sequential_layer_call_and_return_conditional_losses_143zG�D
=�:
0�-
lambda_input�����������
p

 
� "/�,
%�"
0�����������
� �
C__inference_sequential_layer_call_and_return_conditional_losses_147zG�D
=�:
0�-
lambda_input�����������
p 

 
� "/�,
%�"
0�����������
� �
C__inference_sequential_layer_call_and_return_conditional_losses_161tA�>
7�4
*�'
inputs�����������
p

 
� "/�,
%�"
0�����������
� �
C__inference_sequential_layer_call_and_return_conditional_losses_165tA�>
7�4
*�'
inputs�����������
p 

 
� "/�,
%�"
0�����������
� �
(__inference_sequential_layer_call_fn_152mG�D
=�:
0�-
lambda_input�����������
p

 
� ""�������������
(__inference_sequential_layer_call_fn_157mG�D
=�:
0�-
lambda_input�����������
p 

 
� ""�������������
(__inference_sequential_layer_call_fn_170gA�>
7�4
*�'
inputs�����������
p

 
� ""�������������
(__inference_sequential_layer_call_fn_175gA�>
7�4
*�'
inputs�����������
p 

 
� ""�������������
!__inference_signature_wrapper_139�O�L
� 
E�B
@
lambda_input0�-
lambda_input�����������"9�6
4
lambda*�'
lambda�����������