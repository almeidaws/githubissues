# GitHub Issues

Este projeto constru�do em tr�s dias tem por objetivo demonstrar conhecimentos na cria��o de aplicativos para iOS. Ele utiliza boas pr�ticas da pr�pria programa��o e tamb�m do ecossistema criado pela Apple, assim com Inje��o de Depend�ncia com [Swiftinject]([https://github.com/Swinject/Swinject](https://github.com/Swinject/Swinject)) e uma camada de abstra��o sobre as requisi��es de internet por meio do [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

A aplicativo consiste em apresentar as issues do [reposit�rio do Swift da Apple]([https://github.com/apple/swift](https://github.com/apple/swift)) e permitir que elas seja visualizadas com mais detalhes. Ele lista somente as 30 issues mais recentes.

# Arquitetura
O aplicativo possui uma autentica��o com uma conta do GitHub implementada com [Firebase Authentication](https://firebase.google.com/docs/auth) e uma consulta na [API do GitHub](https://developer.github.com/v3/) para recupera��o das issues que s�o apresentadas.

Internamente, o aplicativo do MVC e do princ�pio [Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) para organiza��o dos diret�rios.

![App Preview](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/preview.gif)

# Prototipa��o

## Prototipa��o em papel

Desenvolvedores experientes sabem que resolver um problema � diferente de programar. Foi por esse motivo que resolvi inicialmente esbo�ar o aplicativo em papel, para assim que eu pudesse ficar mais confort�vel com o que seria codificado tendo uma vis�o hol�stica do projeto.

![Protitipa��o em papel](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_papel.jpg)

## Prototipa��o com Adobe XD

Ap�s a etapa de prototipa��o no papel, parti para um recurso que me permitisse entender o funcionamento da solu��o com com um n�vel maior de detalhes. Como o foco � na base do c�digo, n�o houve uma grande preocupa��o com UI, por�m ainda sim � poss�vel notar um cuidado pela aplica��o de conceitos de  UX.

Note que as informa��es mais importantes como o t�tulo da issue e a sua situa��o atual, vari�vel entre aberto e fechado, s�o mais chamativas que informa��es secund�rias como a sua data de cria��o ou seu n�mero identificador.

![Prototipa��o Adobe XD](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_adobe_xd.png)

Apesar disso, ainda assim h� alguns problemas n�o solucionados como, por exemplo, o fato de como apresentar o t�tulo grande de uma issue sem deixar a tela visualmente polu�da.

# Dificuldades

Ao come�ar esse projeto, eu nunca tinha usado o Swiftinject, apenas conhecia brevemente o mecanismo de Inje��o de Depend�ncia do [Vapor]([https://vapor.codes/](https://vapor.codes/)) utilizando a framework [Service]([https://docs.vapor.codes/3.0/service/getting-started/](https://docs.vapor.codes/3.0/service/getting-started/)). Al�m disso, tamb�m nunca havia usando o [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

Mesmo assim, a falta desse conhecimento n�o foi um obst�culo, apenas um contratempo. Utilizando o [CBL]([https://www.challengebasedlearning.org/](https://www.challengebasedlearning.org/)) pude estud�-las e aplic�-las efetivamente no projeto. Certamente n�o � a melhor implementa��o, mas com certeza as boas pr�ticas foram seguidas.

# Scrum

Apesar de que durante a execu��o desse projeto n�o houve a execu��o � risca dos rituais do Scrum, fiz quest�o de utilizar essa framework na *medida certa*, tomando notas das coisas que precisariam serem feitas. Isso me ajudou a manter a vis�o macro do projeto e me orientar durante o seu desenvolvimento.

![Tarefas](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/9a5c0cc9f4a90021a6dfeaa5d52bc750ffeb584d/tarefas.png)

# Programa��o
## Programa��o orientada a objetos
Apesar do Swift ser uma linguagem h�brida, todo o ecossistema do iOS foi pensando de forma orientada primariamente a objetos, por isso, seu uso foi feito intensivamente seguindo os princ�pios SOLID, principalmente o Princ�pio da Responsabilidade �nica.

Por�m, como os princ�pios s�o diretrizes e n�o leis, sua aplica��o foi ponderada para evitar introduzir complexidade no projeto por excessos de abstra��es.

Este � o exemplo de c�digo que poderia ser generalizado, mas n�o foi para evitar *Otimiza��o Prematura*.
```swift
private func setCreationDateLabel() {
    guard let issue = self.controller?.issue else { return }
    let formatter = DateFormatter()
    formatter.dateFormat = "'Created on 'dd/MM/yyyy' at 'HH:mm"
    formatter.locale = Locale.current
    let text = formatter.string(from: issue.createdAt)
    self.controller?.creationDate.text = text
}
```



## Programa��o orientada a protocolos
A programa��o orientada a protocolos materializou-se no uso extensivo de protocolos para defini��o de APIs e diminui��o do acoplamento entre as entidades. N�o houve grande oportunidade para o uso de recursos mais avan�ados como [Protocol Composition]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282)) ou [Protocol Extensions]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521)).

## Programa��o orientada a valor
Foi feito um forte uso desse paradigma na defini��o das entidades de modelo. Elas s�o *structs* para evitar que uma inst�ncia do modelo seja compartilhadas com outras inst�ncias, geralmente *view controllers*, diminuindo assim efeitos colaterais no programa e consequentemente evitando que bugs aconte�am, devido ao compartilhamento de estado.


# Poss�veis melhorias
- Internacionaliza��o e localiza��o
- Acessibilidade
- Armazenamento dos dados para acesso offline

# Author
[Gustavo Almeida]([http://github.com/almeidaws](http://github.com/almeidaws))
