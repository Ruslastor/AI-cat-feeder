class_name DateTime
extends RefCounted

var days_per_month : PackedInt32Array = [31,28,31,30,31,30,31,31,30,31,30,31]

var day : int = 0
var weekday : int = 0
var month : int = 0
var year : int = 0

func _init(day : int, month : int, year : int, weekday : int) -> void:
	self.day = day
	self.weekday = weekday
	self.month = month
	self.year = year
	
	self.days_per_month[1] = 28 + int(!self.year%4)


func add_day() -> void:
	self.day += 1
	self.weekday += 1
	if self.day > days_per_month[self.month - 1]:
		self.month += 1
		self.day = 1

	if self.month > 12:
		self.year += 1
		self.month = 1

	if self.weekday > 7:
		self.weekday = 1
		
	self.days_per_month[1] = 28 + int(!self.year%4)

func sub_day() -> void:
	self.day -= 1
	self.weekday -= 1
	
	if self.day <= 0:
		self.month -= 1

	if self.month <= 0:
		self.year -= 1
		self.month = 12

	if self.weekday <= 0:
		self.weekday = 7

	self.days_per_month[1] = 28 + int(!self.year%4)
	self.day = days_per_month[self.month - 1]

func is_equal_to(date : DateTime) -> bool:
	return self.day == date.day and self.month == date.month and self.year == date.year

func datetime_to_string() -> StringName:
	return str(self.day)+';'+str(self.month)+';'+str(self.year)+';'+str(self.weekday)



static func get_current_datetime() -> DateTime:
	var data : Dictionary = Time.get_datetime_dict_from_system()
	return DateTime.new(int(data.day),int(data.month),int(data.year),int(data.weekday))

static func get_datetime_from_string(string : StringName) -> DateTime:
	var data : PackedStringArray = string.split(';')
	return DateTime.new(int(data[0]),int(data[1]),int(data[2]),int(data[3]))

static func get_dates_from_to(from : String, to : String) -> PackedStringArray:
	var d1 : DateTime = DateTime.get_datetime_from_string(from)
	var d2 : DateTime = DateTime.get_datetime_from_string(to)
	var result : PackedStringArray = []
	while !d1.is_equal_to(d2):
		d1.add_day()
		result.append(d1.datetime_to_string())
	return result




func count_days() -> int:
	var days : int = 0
	for i in self.month - 1:
		days += self.days_per_month[i]
	days += self.day
	return days
