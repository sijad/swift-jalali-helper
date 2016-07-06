# Jalali Calendar Helper
Written in Swift.

Please keep in mind if you're in OS X or IOS you should use `NSCalendarIdentifierPersian` instead. [example here](https://github.com/sijad/today-jalali)

## Example
```
let jh = jalaliHelper()
print(jh.toJalali()) // (1394, 10, 4)
print(jh.getMonth()) // دی
print(jh.getDay()) // جمعه
```

## TODO
* make this cross platform

## License
[MIT](LICENSE)