define variable vdat-data           as date format "99/99/9999" label "Data".

define variable vint-dia            as integer.
define variable vint-mes            as integer.
define variable vint-ano            as integer.

define variable vcha-dia            as character.
define variable vcha-mes            as character.
define variable vcha-ano            as character.

define variable vcha-data-extenso   as character format "x(60)" label "Data por extenso".

define variable vhan-procedures     as handle.


run data-por-extenso--procedures.p persistent set vhan-procedures.

// Interface
display vdat-data.
update vdat-data.

run separar-data in vhan-procedures (input vdat-data, output vint-dia, output vint-mes, output vint-ano).
run nomear-numero-quatro-posicoes in vhan-procedures (input vint-dia, output vcha-dia).
run nomear-mes in vhan-procedures (input vint-mes, output vcha-mes).
run nomear-numero-quatro-posicoes in vhan-procedures (input vint-ano, output vcha-ano).

assign vcha-data-extenso = vcha-dia + " de" + vcha-mes + " de" + vcha-ano.
display vcha-data-extenso.
