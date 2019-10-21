# GitHub Issues

Este projeto tem por objetivo demonstrar conhecimentos na cria��o de aplicativos para iOS. Ele utiliza boas pr�ticas da pr�pria programa��o e tamb�m do ecossistema criado pela Apple, assim com Inje��o de Depend�ncia com [Swiftinject]([https://github.com/Swinject/Swinject](https://github.com/Swinject/Swinject)) e uma camada de abstra��o sobre requisi��es por meio do [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

![App Preview]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/preview.gif](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/preview.gif))

# Prototipa��o

## Prototipa��o em papel

Desenvolvedores experientes sabem resolver um problema � diferente de programar, foi por esse motivo que resolvi inicialmente esbo�ar o aplicativo em papel para que eu pudesse ficar mais confort�vel com o que seria codificado tendo uma vis�o hol�stica do projeto.

![Protitipa��o em papel]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_papel.jpg](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_papel.jpg))

## Prototipa��o com Adobe XD

Ap�s a etapa de prototipa��o no papel, parti para um recurso que me permitisse entender o funcionamento do aplicativo com mais detalhes. Como o foco � na base do c�digo, n�o houve uma grande preocupa��o com UI, por�m ainda sim � poss�vel notar um zelo pela UX.

Note que as informa��es mais importantes como o t�tulo da issue e se ela est� aberta ou fechada s�o mais chamativas que informa��es secund�rias como a sua data de cria��o ou seu n�mero.

![Prototipa��o Adobe XD]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_adobe_xd.png](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_adobe_xd.png))

Apesar disso, h� alguns problemas n�o solucionados como os t�tulos grandes das issues para serem vistos sucintamente no iPhone.

# Dificuldades 

Ao come�ar esse projeto, eu nunca tinha usado o Swiftinject, apenas conhecia brevemente o mecanismo de Inje��o de Depend�ncia do [Vapor]([https://vapor.codes/](https://vapor.codes/)) utilizando a framework [Service]([https://docs.vapor.codes/3.0/service/getting-started/](https://docs.vapor.codes/3.0/service/getting-started/)). Al�m disso, tamb�m nunca havia usando o [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

Mesmo assim, a falta desse conhecimento n�o foi um obst�culo, apenas um contratempo. Utilizando o [CBL]([https://www.challengebasedlearning.org/](https://www.challengebasedlearning.org/)) pude estud�-las e aplic�-las efetivamente no projeto. Certamente n�o � a melhor implementa��o, mas com certeza as boas pr�ticas.

# Scrum

Apesar de que durante a execu��o desse projeto n�o houve a execu��o � riscas dos rituais do Scrum, fiz quest�o de utilizar essa framework na medida certa, tomando notas das coisas que precisariam serem feitas. Isso me ajudou a manter a vis�o macro do projeto.

## Foto

# Programa��o
## Programa��o orientada a objetos
Apesar do Swift ser uma linguagem h�brida, todo o ecossistema do iOS foi pensando de forma orientada primariamente a objetos, por isso, seu uso foi feito intensivamente seguindo os princ�pios SOLID, principalmente o Princ�pio da Responsabilidade �nica.

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

Caso de c�digo que poderia ser generalizado, mas n�o foi para evitar *Otimiza��o Prematura*.

## Programa��o orientada a protocolos
A programa��o orientada a protocolos materializou-se no uso extensivo de protocolos para defini��o de APIs e diminui��o do acoplamento entre as entidades. N�o houve grande oportunidade para uso de [Protocol Composition]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282)) ou [Protocol Extensions]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521)).

## Programa��o orientada a valor
Foi feito um forte uso desse paradigma na defini��o das entidades de model. Elas s�o *structs* para evitar que uma inst�ncia seja compartilhadas com outras inst�ncias, diminuindo assim efeitos colaterais do projeto e consequentemente evitando que bugs aconte�am, devido ao compartilhamento de estado.


# Poss�veis melhorias
- Internacionaliza��o e localiza��o
- Acessibilidade
- Armazenamento dos dados para acesso offline

# Author
[Gustavo Almeida]([http://github.com/almeidaws](http://github.com/almeidaws))
