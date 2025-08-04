import os
import json
import random


if os.path.exists('english.json'):
    with open('english.json', 'r', encoding='utf-8') as f:
        data = json.load(f)


#random_key, random_value = random.choice(list(data.items()))

word_en = input("введите новое английское слово, если новое слово не нужно, то просто введите 'нет: ")
word_ru = input("введите новое русское слово, если новое слово не нужно, то просто введите 'нет: ")

if word_en in "нет" and word_ru in 'нет':
    print("новых слов в словарь не добавилось")
else:
    with open("english.json", "w", encoding="utf-8") as f:
        data[word_en] = word_ru
        json.dump(data, f, ensure_ascii=False, indent=4)
    print("новые слова добавлены в словарь! ")




while True:
    random_key, random_value = random.choice(list(data.items()))

    while True:
        key = input(f"как переводится {random_key} ? : ")
        if key == random_value:
            print("все верно!")
            break
        else:
            print("неправильно, попробуй еще раз")

    extend = input("хотите продолжить? да/нет: ")
    if extend != 'да':
        break
