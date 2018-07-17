import re


def main():
    string = ""
    while True:
        var = input()
        var = re.sub(' *;.*$', '', var)
        if var.find("end") != -1:
            break
        string += var + '\n'
    result = re.findall('\n(\S*?):', string)
    for address in result:
        string = re.sub('\$' + address + '\n',
                        str(len(re.findall('\n', string[:string.find('\n' + address + ':') + 1], re.M))) + '\n', string)
    print(re.sub('.{12}', '', string))


main()
