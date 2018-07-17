import re


def explan(instruction):
    if instruction == "":
        return None
    if instruction.find('end') != -1:
        return -1
    ret = '"'
    if re.search('mov ix,\d\d*', instruction) is not None:
        output = "1"
        num = 0
        if instruction[7:] != '0':
            num = int(instruction[7:], 10)
        init = 64
        while init != 0:
            if num >= init:
                num -= init
                output += "1"
            else:
                output += "0"
            init //= 2
        ret += output + '",-->'
    elif instruction[:3] == "mov":
        ret += '01' + {
            'ax': '000',
            'px': '001',
            'ds': '010',
            'dx': '011',
            'cs': '100',
            'ip': '101',
            'si': '110',
            'ix': '111',
        }.get(instruction[4:6]) + {
                   'ax': '000',
                   'px': '001',
                   'ds': '010',
                   'dx': '011',
                   'cs': '100',
                   'ip': '101',
                   'si': '110',
                   'ix': '111',
               }.get(instruction[7:9]) + '",-->'
    elif instruction[:4] == "push":
        ret += '00101' + {
            'ax': '000',
            'px': '001',
            'ds': '010',
            'dx': '011',
            'cs': '100',
            'ip': '101',
            'si': '110',
            'ix': '111',
        }.get(instruction[5:7]) + '",-->'
    elif instruction[:3] == "pop":
        ret += '00110' + {
            'ax': '000',
            'px': '001',
            'ds': '010',
            'dx': '011',
            'cs': '100',
            'ip': '101',
            'si': '110',
            'ix': '111',
        }.get(instruction[4:6]) + '",-->'
    elif instruction[:3] == "inc":
        ret += '00111' + {
            'ax': '000',
            'px': '001',
            'ds': '010',
            'dx': '011',
            'cs': '100',
            'ip': '101',
            'si': '110',
            'ix': '111',
        }.get(instruction[4:6]) + '",-->'
    elif instruction[:3] == "dec":
        ret += '00011' + {
            'ax': '000',
            'px': '001',
            'ds': '010',
            'dx': '011',
            'cs': '100',
            'ip': '101',
            'si': '110',
            'ix': '111',
        }.get(instruction[4:6]) + '",-->'
    elif instruction[:3] == "out":
        ret += '00010' + {"0": "000",
                          "1": "001",
                          "2": "010",
                          "3": "011",
                          "4": "100",
                          "5": "101",
                          "6": "110",
                          "7": "111"}.get(instruction[4]) + '",-->'
    elif instruction[:2] == "in":
        ret += '000001' + {"0": "00",
                           "1": "01",
                           "2": "10",
                           "3": "11"}.get(instruction[3]) + '",-->'
    else:
        ret += {
                   "jmp cs:px": "00100000",
                   "jmp ax:px": "00100001",
                   "jc cs:px": "00100010",
                   "stos": "00100011",
                   "jz cs:px": "00100100",
                   "j": "00100101",
                   "js cs:px": "00100110",
                   "jodd cs:px": "00100111",
                   "xor ax,px": "00001111",
                   "mode": "00001110",
                   "shl ax,1": "00001101",
                   "or ax,px": "00001100",
                   "lods": "00001011",
                   "shr ax,1": "00001010",
                   "wait": "00001001",
                   "and ax,px": "00001000",
                   "reset": "00000011",
                   "jz ax:px": "00000010",
                   "add ax,px": "00000001",
                   "delay": "00000000", }.get(instruction, 'error') + '",-->'
    ret += instruction + "<\n"
    return ret


def main():
    total = ""
    instruction_list = ""
    cnt = 0
    while True:
        print('%03d-->' % cnt, end="")
        string = input()
        try:
            result = explan(string)
        except TypeError:
            print('error!')
            continue

        if string == "l":
            print(instruction_list, end="")
        elif string == "d":
            total = total[:total[:-1].rfind('\n') + 4]
            instruction_list = instruction_list[:instruction_list[:-1].rfind('\n') + 1]
            cnt -= 1
            print(instruction_list, end="")
        elif result is None:
            continue
        elif result == -1:
            break
        elif result.find('error') != -1:
            print('error!')
            continue
        else:
            instruction_list += '%03d-->' % cnt + string + '\n'
            cnt += 1
            total += result + '   '
    print(total)
    print('%d' % (cnt + 19))


main()
