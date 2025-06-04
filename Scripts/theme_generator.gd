@tool
extends Node
class_name ThemeGenerator

@export var theme_baseplate:Theme
@export var output_theme:Theme
@export_tool_button("Generate Theme") var themegen_func = generate_theme
@export_subgroup("Colors")
@export var bg_color:Color
@export var accent_color:Color
@export var accent_color_focused:Color
@export var fg_color:Color
@export var fg_focus_color:Color
@export var popup_panel_bg_color:Color
@export var popup_panel_border_color:Color
@export var hover_color:Color
@export var font_color:Color
@export var font_color_hover:Color
@export var font_color_placeholder:Color
@export var font_color_button:Color
@export var icon_color:Color
@export var icon_color_spinbox:Color
@export var icon_color_disabled:Color

@export_subgroup("Fonts")
@export var main_font:Font

@export_subgroup("Icons")
@export var checkbox_toggled:Texture2D
@export var checkbox_untoggled:Texture2D
@export var down_icon:Texture2D
@export var up_icon:Texture2D
@export var dropdown_icon:Texture2D
@export var folder_icon:Texture2D
@export var info_icon:Texture2D
@export var palette_icon:Texture2D
@export var radio_toggled:Texture2D
@export var radio_untoggled:Texture2D


func generate_theme():
	output_theme = theme_baseplate
	
	# Main Colors
	change_theme_item(&"panel",&"BGPanel",&"bg_color",bg_color)
	
	change_theme_item(&"focus",&"LineEdit",&"bg_color",fg_focus_color)
	change_theme_item(&"normal",&"LineEdit",&"bg_color",fg_color)
	
	# Buttons
	change_theme_item(&"focus",&"OptionButton",&"bg_color",fg_focus_color)
	change_theme_item(&"hover",&"OptionButton",&"bg_color",fg_focus_color)
	change_theme_item(&"normal",&"OptionButton",&"bg_color",fg_color)
	change_theme_item(&"focus",&"Button",&"bg_color",accent_color_focused)
	change_theme_item(&"hover",&"Button",&"bg_color",accent_color_focused)
	change_theme_item(&"hover_pressed",&"Button",&"bg_color",accent_color_focused)
	change_theme_item(&"normal",&"Button",&"bg_color",accent_color)
	#change_theme_item(&"focus",&"Button",&"bg_color",accent_color_focused)

	# Popups
	change_theme_item(&"panel",&"Panel",&"bg_color",popup_panel_bg_color)
	change_theme_item(&"panel",&"Panel",&"border_color",popup_panel_border_color)
	change_theme_item(&"hover",&"PopupMenu",&"bg_color",hover_color)
	change_theme_item(&"panel",&"PopupMenu",&"bg_color",fg_focus_color)
	change_theme_item(&"panel",&"PopupMenu",&"border_color",accent_color)
	# Spinbox
	change_theme_item(&"down_background",&"SpinBox",&"bg_color",fg_color)
	change_theme_item(&"down_background_disabled",&"SpinBox",&"bg_color",fg_focus_color)
	change_theme_item(&"down_background_hovered",&"SpinBox",&"bg_color",fg_focus_color)
	change_theme_item(&"down_background_pressed",&"SpinBox",&"bg_color",accent_color)
	
	change_theme_item(&"up_background",&"SpinBox",&"bg_color",fg_color)
	change_theme_item(&"up_background_disabled",&"SpinBox",&"bg_color",fg_color)
	change_theme_item(&"up_background_hovered",&"SpinBox",&"bg_color",fg_color)
	change_theme_item(&"up_background_pressed",&"SpinBox",&"bg_color",accent_color)
	
	change_theme_item(&"focus",&"SpinBoxInnerLineEdit",&"bg_color",fg_color)
	change_theme_item(&"normal",&"SpinBoxInnerLineEdit",&"bg_color",fg_focus_color)

	# Font Color
	change_theme_color(&"caret_color",&"LineEdit",font_color)
	change_theme_color(&"font_color",&"LineEdit",font_color)
	change_theme_color(&"font_color",&"Button",font_color_button)
	change_theme_color(&"font_color",&"Button",font_color_button)
	change_theme_color(&"font_hover_color",&"Button",font_color_hover)
	change_theme_color(&"font_focus_color",&"Button",font_color)
	change_theme_color(&"font_hover_pressed",&"Button",font_color_hover)
	change_theme_color(&"font_color",&"OptionButton",font_color) #OptionButton may use different styling
	change_theme_color(&"font_placeholder_color",&"LineEdit",font_color_placeholder)
	change_theme_color(&"font_color",&"PopupMenu",font_color)
	change_theme_color(&"font_disabled_color",&"PopupMenu",font_color_placeholder)
	change_theme_color(&"font_hover_color",&"PopupMenu",font_color_placeholder)
	change_theme_color(&"default_color",&"RichTextLabel",font_color)
	change_theme_color(&"font_color",&"TextEdit",font_color)
	change_theme_color(&"font_placeholder_color",&"TextEdit",font_color_placeholder)
	
	# Icon Modulate
	change_theme_color(&"icon_pressed_color",&"Button",icon_color)
	change_theme_color(&"icon_normal_color",&"Button",icon_color)
	change_theme_color(&"icon_hover_pressed_color",&"Button",icon_color)
	change_theme_color(&"icon_hover_color",&"Button",icon_color)
	change_theme_color(&"icon_focus_color",&"Button",icon_color)
	change_theme_color(&"icon_disabled_color",&"Button",icon_color_disabled)
	
	#change_theme_color(&"down_disabled_icon_modulate",&"SpinBox",icon_color)
	change_theme_color(&"down_hover_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"down_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"down_pressed_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"down_disabled_icon_modulate",&"SpinBox",icon_color_disabled)
	
	change_theme_color(&"up_hover_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"up_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"up_pressed_icon_modulate",&"SpinBox",icon_color_spinbox)
	change_theme_color(&"up_disabled_icon_modulate",&"SpinBox",icon_color_disabled)
	
	# Fonts
	change_theme_font(&"font",&"LineEdit",main_font)
	change_theme_font(&"font",&"PopupMenu",main_font)
	change_theme_font(&"normal_font",&"RichTextLabel",main_font)
	change_theme_font(&"font",&"TextEdit",main_font)
	
	
	# Icons
	change_theme_icon(&"arrow",&"OptionButton",dropdown_icon)
	
	change_theme_icon(&"checked",&"PopupMenu",checkbox_toggled)
	change_theme_icon(&"checked_disabled",&"PopupMenu",checkbox_untoggled)
	change_theme_icon(&"radio_checked",&"PopupMenu",radio_toggled)
	change_theme_icon(&"radio_checked_disabled",&"PopupMenu",radio_untoggled)
	change_theme_icon(&"radio_unchecked",&"PopupMenu",radio_untoggled)
	change_theme_icon(&"radio_unchecked_disabled",&"PopupMenu",radio_untoggled)
	
	
	output_theme.resource_path = ""
	output_theme.resource_name = "Theme Customized"
	
func change_theme_item(item_name:StringName,type_name:StringName,variable_to_change:StringName,value:Variant):
	var thing_to_change:Resource = output_theme.get_theme_item(Theme.DATA_TYPE_STYLEBOX,item_name,type_name)
	thing_to_change.set(variable_to_change,value)
	output_theme.set_theme_item(Theme.DATA_TYPE_STYLEBOX,item_name,type_name,thing_to_change)

func change_theme_color(item_name:StringName,type_name:StringName,value:Color):
	output_theme.set_theme_item(Theme.DATA_TYPE_COLOR,item_name,type_name,value)

func change_theme_font(item_name:StringName,type_name:StringName,value:Font):
	output_theme.set_theme_item(Theme.DATA_TYPE_FONT,item_name,type_name,value)

func change_theme_icon(item_name:StringName,type_name:StringName,value:Texture2D):
	output_theme.set_theme_item(Theme.DATA_TYPE_ICON,item_name,type_name,value)
