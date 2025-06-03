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
@export var font_color_placeholder:Color

func generate_theme():
	output_theme = theme_baseplate
	change_theme_item(&"panel",&"BGPanel",&"bg_color",bg_color)
	
	change_theme_item(&"focus",&"LineEdit",&"bg_color",fg_focus_color)
	change_theme_item(&"normal",&"LineEdit",&"bg_color",fg_color)
	
	# Buttons
	change_theme_item(&"focus",&"OptionButton",&"bg_color",fg_focus_color)
	change_theme_item(&"hover",&"OptionButton",&"bg_color",fg_focus_color)
	change_theme_item(&"normal",&"OptionButton",&"bg_color",fg_color)
	change_theme_item(&"focus",&"Button",&"bg_color",accent_color)
	change_theme_item(&"hover",&"Button",&"bg_color",accent_color_focused)
	change_theme_item(&"hover_pressed",&"Button",&"bg_color",accent_color)
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
	change_theme_color(&"font_color",&"Button",font_color)
	change_theme_color(&"font_placeholder_color",&"LineEdit",font_color_placeholder)
	change_theme_color(&"font_color",&"PopupMenu",font_color)
	change_theme_color(&"font_disabled_color",&"PopupMenu",font_color_placeholder)
	change_theme_color(&"font_hover_color",&"PopupMenu",font_color_placeholder)
	change_theme_color(&"default_color",&"RichTextLabel",font_color)
	change_theme_color(&"font_color",&"TextEdit",font_color)
	change_theme_color(&"font_placeholder_color",&"TextEdit",font_color)
	
	output_theme.resource_path = ""
	output_theme.resource_name = "Theme Customized"
	
func change_theme_item(item_name:StringName,type_name:StringName,variable_to_change:StringName,value:Variant):
	var thing_to_change:Resource = output_theme.get_theme_item(Theme.DATA_TYPE_STYLEBOX,item_name,type_name)
	thing_to_change.set(variable_to_change,value)
	output_theme.set_theme_item(Theme.DATA_TYPE_STYLEBOX,item_name,type_name,thing_to_change)

func change_theme_color(item_name:StringName,type_name:StringName,value:Color):
	output_theme.set_theme_item(Theme.DATA_TYPE_COLOR,item_name,type_name,value)
