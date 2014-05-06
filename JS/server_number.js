var express = require("express");
var app = express();
var http = require('http');
var request = require('request');
var operators = {
  77: 'NEXTEL (SMP)',
  78: 'E_NEXTEL (SME)',
  23: 'TELEMIG',
  12: 'CTBC',
  14: 'BRASIL TELECOM',
  20: 'VIVO',
  21: 'CLARO',
  31: 'TNL (Oi)',
  24: 'AMAZONIA',
  37: 'UNICEL',
  41: 'TIM',
  43: 'SERCOMERCIO',
  81: 'Datora',
  98: 'Fixo',
  99: 'Número Não encontrado',
  999: 'Chave invalida ou Numero enviado está incorreto.',
  991: 'Limite Excedido (controle do cliente)',
  992: 'IP sem acesso (Verifique, na área do cliente, se o IP se sua máquina tem acesso )',
  994: 'Chave Bloqueada (Verificar junto ao financeiro Telein)',
  995: 'IP excedeu 6 consultas/hora nas últimas 24 horas',
  990: 'IP black listed'
};

app.get('/phone/:number', function(req, res){
  var number  = req.params.number;
  var url     = 'http://consultanumero3.telein.com.br/sistema/consulta_numero.php?chave=senhasite&numero=' + number;

  request(url, function(error, response, body){
    if (!error && response.statusCode == 200){
      var operator_name = getOperator(body);
      var response  = { number: number, operator: operator_name };
      res.json(response);
    }
  });

});

function getOperator(body){
  var operator = body.split("#")[0];
  return operators[operator];
}

app.listen(3000);
console.log('starting server at localhost:3000');
console.log('route: /phone/:number');
