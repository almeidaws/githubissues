# GitHub Issues

Este projeto tem por objetivo demonstrar conhecimentos na criação de aplicativos para iOS. Ele utiliza boas práticas da própria programação e também do ecossistema criado pela Apple, assim com Injeção de Dependência com [Swiftinject]([https://github.com/Swinject/Swinject](https://github.com/Swinject/Swinject)) e uma camada de abstração sobre requisições por meio do [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

![App Preview]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/preview.gif](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/preview.gif))

# Prototipação

## Prototipação em papel

Desenvolvedores experientes sabem resolver um problema é diferente de programar, foi por esse motivo que resolvi inicialmente esboçar o aplicativo em papel para que eu pudesse ficar mais confortável com o que seria codificado tendo uma visão holística do projeto.

![Protitipação em papel]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_papel.jpg](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_papel.jpg))

## Prototipação com Adobe XD

Após a etapa de prototipação no papel, parti para um recurso que me permitisse entender o funcionamento do aplicativo com mais detalhes. Como o foco é na base do código, não houve uma grande preocupação com UI, porém ainda sim é possível notar um zelo pela UX.

Note que as informações mais importantes como o título da issue e se ela está aberta ou fechada são mais chamativas que informações secundárias como a sua data de criação ou seu número.

![Prototipação Adobe XD]([https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_adobe_xd.png](https://bitbucket.org/recrutamento_jya_ios/recrutamento-ios-jya-almeidaws/raw/997835932d037d0ffa4e98107e38a09dd5503fbc/prototipo_adobe_xd.png))

Apesar disso, há alguns problemas não solucionados como os títulos grandes das issues para serem vistos sucintamente no iPhone.

# Dificuldades 

Ao começar esse projeto, eu nunca tinha usado o Swiftinject, apenas conhecia brevemente o mecanismo de Injeção de Dependência do [Vapor]([https://vapor.codes/](https://vapor.codes/)) utilizando a framework [Service]([https://docs.vapor.codes/3.0/service/getting-started/](https://docs.vapor.codes/3.0/service/getting-started/)). Além disso, também nunca havia usando o [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

Mesmo assim, a falta desse conhecimento não foi um obstáculo, apenas um contratempo. Utilizando o [CBL]([https://www.challengebasedlearning.org/](https://www.challengebasedlearning.org/)) pude estudá-las e aplicá-las efetivamente no projeto. Certamente não é a melhor implementação, mas com certeza as boas práticas.

# Scrum

Apesar de que durante a execução desse projeto não houve a execução à riscas dos rituais do Scrum, fiz questão de utilizar essa framework na medida certa, tomando notas das coisas que precisariam serem feitas. Isso me ajudou a manter a visão macro do projeto.

## Foto

# Programação
## Programação orientada a objetos
Apesar do Swift ser uma linguagem híbrida, todo o ecossistema do iOS foi pensando de forma orientada primariamente a objetos, por isso, seu uso foi feito intensivamente seguindo os princípios SOLID, principalmente o Princípio da Responsabilidade Única.

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

Caso de código que poderia ser generalizado, mas não foi para evitar *Otimização Prematura*.

## Programação orientada a protocolos
A programação orientada a protocolos materializou-se no uso extensivo de protocolos para definição de APIs e diminuição do acoplamento entre as entidades. Não houve grande oportunidade para uso de [Protocol Composition]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282)) ou [Protocol Extensions]([https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521)).

## Programação orientada a valor
Foi feito um forte uso desse paradigma na definição das entidades de model. Elas são *structs* para evitar que uma instância seja compartilhadas com outras instâncias, diminuindo assim efeitos colaterais do projeto e consequentemente evitando que bugs aconteçam, devido ao compartilhamento de estado.


# Possíveis melhorias
- Internacionalização e localização
- Acessibilidade
- Armazenamento dos dados para acesso offline

# Author
[Gustavo Almeida]([http://github.com/almeidaws](http://github.com/almeidaws))
