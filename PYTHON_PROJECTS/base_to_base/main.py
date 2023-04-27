def base_converter(value, base, base_to_converse):
    # CONVERSION A BASE 10
    number = 0
    power = 0

    # RECORRER DE FORMA INVERSA LA CADENA DEL VALOR (PASA DE SER 123 A 321)
    for i in reversed(str(value)):
        # POTENCIA ACORDE A LA POSICION DEL NUMBERO UNIDADES, DECENAS, CENTENAS, ETC.
        powered_base = pow(base, power)

        # EL NUMERO VA A SER IGUAL A LA BASE (10) MULTIPLICADO POR EL NUMERO EN LA POSICION
        number += int(i)*powered_base

        power += 1

    converted_value = ''

    # CONVERTIR A BASE DESEADA
    while number > 0:
        converted_value = str(number % base_to_converse)+converted_value
        number //= base_to_converse

    return int(converted_value)


if __name__ == '__main__':
    while True:
        try:
            print('CONVERSION DE BASE A BASE')

            value = int(input('VALOR A CONVERTIR: '))
            base = int(input('BASE DEL NUMERO INGRESADO: '))
            base_to_converse = int(input('BASE A LA QUE SE VA A CONVERTIR: '))

            print(f"\nEL NUMERO {value} DE BASE {base} A BASE {base_to_converse} ES: "
                  f"{base_converter(value, base, base_to_converse)}\n")

        except:
            print('HASTA LUEGO')
            break
