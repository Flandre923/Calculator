class_name Calculator extends RefCounted

signal current_num_change
signal result_change 

var new_number := true
var result:String =  ""
var current_num:String = "0"
var num1:String
var sign:String
var num2:String

func _init():
	#print("calculator init")
	#input_number(2)
	#mul()
	#input_number(5)
	#equal()
	#
	#print(result)
	#print(current_num)
	current_num_change.emit()
	result_change.emit()

func input_number(value:int):
	if new_number:
		current_num = ""
		new_number = false
	current_num += str(value)
	current_num_change.emit()


func calculator_function(_sign:String):
	new_number = true
	if not num1:
		num1 = current_num
		sign = _sign
		get_result()
		result_change.emit()
		current_num_change.emit()
		return 
	var res_num = calculator()
	sign = _sign
	num1 = res_num
	current_num	 = res_num
	get_result()
	current_num_change.emit()
	
func add():
	calculator_function("+")

func sub():
	calculator_function("-")

func mul():
	calculator_function("*")
	
func equal():
	if not current_num:
		return 
	if not num1:
		num1 = current_num
		return 
	if not num2:
		num2 = current_num
	var res_num  = calculator()
	current_num = res_num
	new_number = true
	get_result()
	current_num_change.emit()
	

func get_result():
	result = num1+sign
	if num2:
		result += num2 + "="
	result_change.emit()
	
func calculator():
	var res_num:float
	if sign == "+":
		res_num = float(num1) + float(current_num)
	if sign == "-":
		res_num = float(num1) - float(current_num)
	if sign == "*":
		res_num = float(num1) * float(current_num)
	if sign == "=":
		res_num = float(num1) + float(current_num)
	return str(res_num)
	
