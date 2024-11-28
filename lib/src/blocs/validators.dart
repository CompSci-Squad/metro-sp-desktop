import 'dart:async';
import 'package:email_validator/email_validator.dart';

mixin Validators{
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      //faça um if/else
      //usando o EmailValidator, verifique se o e-mail é válido
      //se for válido, apenas adicione o e-mail ao sink
      //caso contrário adicione um ERRO ao sink com a mensagem "E-mail inválido"
      if(EmailValidator.validate(email)){
        sink.add(email);  
      }
      else{
        sink.addError('E-mail inválido');
      }      
    }
  );

  //a senha é válida se tiver, pelo menos, 4 caracteres
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 4){
        sink.add(password);
      }
      else{
        sink.addError('Senha deve ter, pelo menos, 4 caracteres');
      }
    }
  );
}

//visitar o pub.dev e encontrar um pacote apropriado para a validação de e-mail