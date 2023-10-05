GDPC                                                                                          P   res://.godot/exported/133200997/export-609f762188a68253d349ec58c4f3a8d3-game.scn@            �@.�u#+�]Ͻ'CU    X   res://.godot/exported/133200997/export-79f6a23a93e6c7b4d685c3b8fe04e7c4-dollar_store.scn              �3�b٭�"�U�ʲ�=    ,   res://.godot/global_script_class_cache.cfg  `*             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex`      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  @.      \       |I�5Oh�VxKF�->       res://dollar_store.gd   &      p      �� J��~�&�w$#<$        res://dollar_store.tscn.remap   �)      i       ڒ=����u���(       res://game.gd                ���Q����˪摓��       res://game.tscn.remap   �)      a       �?��� �ު��y�       res://icon.svg  �*      �      C��=U���^Qu��U3       res://icon.svg.import   @%      �        i~fCԜ}�;nJM       res://project.binary�.      �      z!��K��#�����O    !�o(��![O�4RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://dollar_store.gd ��������      local://PackedScene_uplht          PackedScene          	         names "   #      DollarStore    script    Node2D 
   ColorRect    offset_left    offset_top    offset_right    offset_bottom    color    Dollar    Label    layout_mode    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    text    ColorRect2    Timer 
   autostart    DragButton 	   modulate    size_flags_vertical    Button    UpgradeButton    mouse_filter 	   disabled    _on_timer_timeout    timeout    _on_drag_button_pressed    pressed    _on_upgrade_button_pressed    	   variants    "                  �     ��     C     C   ϼ<>��(>���=  �?     ��     ��     �B     8�   s� >���>      �?                  ?     ��     8�     �A     8A            $1!!!!      hB     C                 �?           �?  �?  �?         �     ��     C     C           
�     ��     C     C      node_count             nodes     �   ��������       ����                            ����                                                	   ����                        	      
              
   
   ����                                                                                                   ����                                                   ����                           ����                                                         ����                         !                               conn_count             conns                                       !                         !   "                    node_paths              editable_instances              version             RSRCqextends Control


const DOLLARSTORE = preload("res://dollar_store.tscn")

var current_cost = 1

var current_money = 10

var dollarstores = []

var upgrade_cost = 10

var pick_a_store = false

var dragging = false

var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_cost()
	update_money()
	update_upgrade_cost()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !win && current_money > 1000:
		win = true
		$yayyouwin.show()


func update_cost():
	$UI/CostLabel.text = "$" + str(current_cost) + " cost"


func update_money():
	$TOPUI/MoneyDollars.text = "You have $" + str(current_money) + " dollars"


func update_upgrade_cost():
	$"UI/UpgradeButton'".text = "Upgrade Store (" + str(upgrade_cost) + ")"


func _on_button_pressed():
	var diff = current_money - current_cost
	if (diff < 0):
		return
	
	current_money = diff
	
	var randpos = Vector2(randi_range(0, 1920), randi_range(0, 1080))
	var store = DOLLARSTORE.instantiate()
	store.global_position = randpos
	$Stores.add_child(store)
	
	dollarstores.append(store)
	
	current_cost += 1
	update_cost()
	update_money()


func upgrade_cost_func():
	var diff = current_money - upgrade_cost
	if (diff < 0):
		_on_upgrade_button_pressed()
		return false
	
	upgrade_cost += 5
	
	current_money = diff
	pick_a_store = false
	for store in dollarstores:
		store.get_node("UpgradeButton").disabled = true
		store.get_node("UpgradeButton").mouse_filter = store.get_node("UpgradeButton").MOUSE_FILTER_IGNORE
	
	update_upgrade_cost()
	
	return true


func _on_upgrade_button_pressed():
	if pick_a_store:
		pick_a_store = false
		for store in dollarstores:
			store.get_node("UpgradeButton").disabled = true
			store.get_node("UpgradeButton").mouse_filter = store.get_node("UpgradeButton").MOUSE_FILTER_IGNORE
	else:
		pick_a_store = true
		for store in dollarstores:
			store.get_node("UpgradeButton").disabled = false
			store.get_node("UpgradeButton").mouse_filter = store.get_node("UpgradeButton").MOUSE_FILTER_STOP
��c3��ԫ��6JRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://game.gd ��������      local://PackedScene_1a40v          PackedScene          	         names "   #      Game    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    size_flags_vertical    script    Control    Stores    Node2D    UI    z_index    anchor_top    HBoxContainer    Button $   theme_override_font_sizes/font_size    text 
   CostLabel    Label    UpgradeButton'    TOPUI    offset_right    offset_bottom    MoneyDollars 
   yayyouwin    visible    anchor_left    offset_left    offset_top    _on_button_pressed    pressed    _on_upgrade_button_pressed    	   variants                        �?                                                Buy DOllar Store
       $3 cost       Upgrade Store ($20)       B      YUou have the $10 dolalrs                    ?     ��     8�     �A     8A   d         your win!!!!       node_count    	         nodes     �   ��������
       ����	                                                      	                        ����                      ����                                                                    ����                  	                    ����                  
                    ����                                       ����                                            ����                                       ����                                                                                                       conn_count             conns               !                         !   "                    node_paths              editable_instances              version             RSRCw'xf���J�GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ ,~[�x_nM|S[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cnfnhuddgpjws"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 C{�5�l�,'5!r��extends Node2D


var level = 1


var dollar_amount = 1


var being_dragged = false


@onready var parent = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	$UpgradeButton.mouse_filter = $UpgradeButton.MOUSE_FILTER_IGNORE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Dollar/Label.text = "$" + str(dollar_amount) + "!!!"
	
	if being_dragged:
		global_position = get_global_mouse_position()


func _on_timer_timeout():
	parent.current_money += dollar_amount
	parent.update_money()


func upgrade():
	if level == 1:
		dollar_amount = 5
	elif level == 2:
		dollar_amount = 10
	else:
		dollar_amount += 5
	level += 1


func _on_upgrade_button_pressed():
	if parent.upgrade_cost_func():
		upgrade()


func _on_drag_button_pressed():
	if !parent.dragging:
		being_dragged = !being_dragged
[remap]

path="res://.godot/exported/133200997/export-79f6a23a93e6c7b4d685c3b8fe04e7c4-dollar_store.scn"
[ޗ���[remap]

path="res://.godot/exported/133200997/export-609f762188a68253d349ec58c4f3a8d3-game.scn"
�F�g��G�q�list=Array[Dictionary]([])
H� %<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
"��!�/_�>   p��E��B   res://dollar_store.tscn�-e�i   res://game.tscn1F��O   res://icon.svg�ϖ#ECFG      application/config/name         DollarStore    application/run/main_scene         res://game.tscn    application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8  #   rendering/renderer/rendering_method         gl_compatibilityjOzm