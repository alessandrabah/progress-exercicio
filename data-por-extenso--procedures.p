procedure separar-data:

    // entrada
    define input parameter pdat-data as date.
    
    // sa¡da
    define output parameter pint-dia as integer.
    define output parameter pint-mes as integer.
    define output parameter pint-ano as integer.
    
 
    // Separando dia, mˆs e ano da data digitada
    pint-dia = day(pdat-data).
    pint-mes = month(pdat-data).
    pint-ano = year(pdat-data).

end.

procedure nomear-mes:
   
    // entrada
    define input parameter pint-mes     as integer.
    
    // sa¡da
    define output parameter pcha-mes    as character.

    
    define variable vcha-lista-mes as character initial " janeiro, fevereiro, mar‡o, abril, maio, junho, julho, agosto, setembro, outubro, novembro, dezembro".
    
    assign pcha-mes = string(pint-mes).
    
    // Busca o nome do mˆs da lista vcha-lista-mes de acordo com a vint-mes
    assign pcha-mes = entry(pint-mes, vcha-lista-mes).

end.


procedure separar-numero:

    // entrada
    define input parameter ipint-numero     as integer.
    
    // sa¡da
    define output parameter opint-unidade   as integer.
    define output parameter opint-dezena    as integer.
    define output parameter opint-centena   as integer.
    define output parameter opint-milhar    as integer.
    
    define variable vcha-numero as character.

    // processamento
    // para acrecentar os zeros na frente do n£mero, usar o fill("o que ser  acrescentado", n£merodeposi‡äes - length(string(nomedavariavel)
    assign vcha-numero = fill("0", 4 - length(string(ipint-numero))) + string(ipint-numero).

    assign opint-unidade  = int(substring(vcha-numero, 4, 1))
           opint-dezena   = int(substring(vcha-numero, 3, 1))
           opint-centena  = int(substring(vcha-numero, 2, 1))
           opint-milhar   = int(substring(vcha-numero, 1, 1)).

end.

procedure nomear-unidade:

    // entrada
    define input parameter ipint-unidade   as integer.
    
    // sa¡da
    define output parameter opcha-unidade  as character.

    
    define variable vcha-lista-nome as character initial " um, dois, trˆs, quatro, cinco, seis, sete, oito, nove, zero".

    if ipint-unidade = 0 then
        assign ipint-unidade = 10.

    assign opcha-unidade    = entry(ipint-unidade, vcha-lista-nome).

end.


procedure nomear-dezena:

    // entrada
    define input parameter ipint-unidade   as integer.
    
    // sa¡da
    define output parameter opcha-unidade  as character.

    
    define variable vcha-lista-nome  as character initial " dez, vinte, trinta, quarenta, cinquenta, sessenta, setenta, oitenta, noventa,".

    if ipint-unidade = 0 then
        assign ipint-unidade = 10.

    assign opcha-unidade    = entry(ipint-unidade, vcha-lista-nome).

end.


procedure nomear-centena:

    // entrada
    define input parameter ipint-unidade   as integer.
    
    // sa¡da
    define output parameter opcha-unidade  as character.

    
    define variable vcha-lista-nome  as character initial " cem, duzentos, trezentos, quatrocentos, quinhentos, seiscentos, setecentos, oitocentos, novecentos,".

    if ipint-unidade = 0 then
        assign ipint-unidade = 10.

    assign opcha-unidade    = entry(ipint-unidade, vcha-lista-nome).

end.


procedure nomear-milhar:

    // entrada
    define input parameter ipint-unidade   as integer.
    
    // sa¡da
    define output parameter opcha-unidade  as character.

    
    define variable vcha-lista-nome  as character initial " mil, dois mil, trˆs mil, quatro mil, cinco mil, seis mil, sete mil, oito mil, nove mil,".

    if ipint-unidade = 0 then
        assign ipint-unidade = 10.

    assign opcha-unidade    = entry(ipint-unidade, vcha-lista-nome).

end.

procedure nomear-numero-quatro-posicoes:

    // entrada
    define input parameter ipint-numero as integer.

    // saida
    define output parameter opcha-nome-numero as character.

    // variaveis
    define variable vint-unidade    as integer.
    define variable vint-dezena     as integer.
    define variable vint-centena    as integer.
    define variable vint-milhar     as integer.
    
    define variable vcha-unidade    as character.
    define variable vcha-dezena     as character.
    define variable vcha-centena    as character.
    define variable vcha-milhar     as character.

    define variable vcha-lista-dezenas-dez  as character initial ", onze, doze, treze, quatorze, quinze, dezesseis, dezessete, dezoito, dezenove".

    run separar-numero in this-procedure (input ipint-numero, output vint-unidade, output vint-dezena, output vint-centena, output vint-milhar).

    run nomear-unidade in this-procedure (input vint-unidade, output vcha-unidade).
    run nomear-dezena  in this-procedure (input vint-dezena,  output vcha-dezena).
    run nomear-centena in this-procedure (input vint-centena, output vcha-centena).
    run nomear-milhar  in this-procedure (input vint-milhar,  output vcha-milhar).
    
    // trata unidade
    if vcha-unidade <> " zero" and (vcha-dezena <> "" or vcha-centena <> "" or vcha-milhar <> "") then
        assign vcha-unidade = " e" + vcha-unidade.
    else if vcha-unidade = " zero" and (vcha-dezena <> "" or vcha-centena <> "" or vcha-milhar <> "") then
        assign vcha-unidade = "".
    
    // trata dezena
    if vcha-dezena = " dez" and vcha-unidade <> "" then
        assign vcha-dezena = entry(vint-unidade + 1, vcha-lista-dezenas-dez)
               vcha-unidade = "".
    
    if vcha-dezena <> "" and (vcha-centena <> "" or vcha-milhar <> "") then
        assign vcha-dezena = " e" + vcha-dezena.
    
    // trata centena
    if vcha-centena = " cem" and (vcha-dezena <> "" or vcha-unidade <> "") then
        assign vcha-centena = " cento".
    else if vcha-centena <> "" and vcha-milhar <> "" and vcha-dezena = "" then 
        assign vcha-centena = " e" + vcha-centena.
    
    assign opcha-nome-numero = vcha-milhar + vcha-centena + vcha-dezena + vcha-unidade.

end.
