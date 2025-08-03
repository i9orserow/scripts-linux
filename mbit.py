
mbit = int(input('введите скорость в мбит/c: '))

gb = int(input('введите кол-во скачивания в гб: '))

gbh = mbit*60*60/8/1024

result = gb/gbh

print('скачается через: ', round(result, 1), "ч")

