# Script para mudar o st de cor de acordo com o pywal.

def importa():
    L = []
    nome = "./colors"
    with open(nome, "r", encoding = "utf-8") as palette:
        for linha in palette:
            cor = linha[:-1]
            L.append(cor)
    return L 

def escreve(L):
    with open("palette-st", "w") as out:
        out.write('/* Terminal colors (16 first used in escape sequence) */\n')
        out.write('static const char *colorname[] = {\n')
        out.write('\n')
        out.write('  /* 8 normal colors */\n')
        for i in [0,1,2,3,4,5,6,7]:
            formato = '  ['+str(i)+'] = "'+L[i]+'",'
            out.write(formato+'\n')
        out.write('\n  /* 8 bright colors */\n')
        for i in [8,9,10,11,12,13,14,15]:
            if i in [8,9]:
                formato = '  ['+str(i)+']  = "'+L[i]+'",'
                out.write(formato+'\n')
            else:
                formato = '  ['+str(i)+'] = "'+L[i]+'",'
                out.write(formato+'\n')
        out.write('\n  [255] = 0,\n')
        out.write('\n  /* special colors */\n')
        out.write('  [256] = "'+L[0]+'", /* background */\n')
        out.write('  [257] = "'+L[15]+'", /* foreground */\n')
        out.write('};\n')
        out.write('\n/* Default colors (colorname index) */\n')
        out.write('unsigned int defaultfg = 257;\n')
        out.write('unsigned int defaultbg = 256;\n')
        out.write('static unsigned int defaultcs = 257;\n')
        out.write('static unsigned int defaultrcs = 256;\n')
        out.write('\n/*\n')
        out.write(' * Colors used, when the specific fg == defaultfg. So in reverse mode this\n')
        out.write(' * will reverse too. Another logic would only make the simple feature too\n')
        out.write(' * complex.\n */\n')
        out.write('static unsigned int defaultitalic = 7;\n')
        out.write('static unsigned int defaultunderline = 7;')

def main():
    L = importa()
    escreve(L)

if __name__ == '__main__':
    main()
