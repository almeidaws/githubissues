# GitHub Issues

Este projeto construído em três dias tem por objetivo demonstrar conhecimentos na criação de aplicativos para iOS. Ele utiliza boas práticas da própria programação e também do ecossistema criado pela Apple, assim com Injeção de Dependência com [Swinject](https://github.com/Swinject/Swinject) e uma camada de abstração sobre as requisições de internet por meio do [Moya](https://github.com/Moya/Moya).

A aplicativo consiste em apresentar as issues do [repositório do Swift da Apple](https://github.com/apple/swift) e permitir que elas seja visualizadas com mais detalhes. Ele lista somente as 30 issues mais recentes.

# Arquitetura
O aplicativo possui uma autenticação com uma conta do GitHub implementada com [Firebase Authentication](https://firebase.google.com/docs/auth) e uma consulta na [API do GitHub](https://developer.github.com/v3/) para recuperação das issues que são apresentadas.

Internamente, o aplicativo do MVC e do princípio [Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) para organização dos diretórios.

![App Preview](https://github.com/almeidaws/githubissues/blob/master/preview.gif?raw=true)

# Prototipação

## Prototipação em papel

Desenvolvedores experientes sabem que resolver um problema é diferente de programar. Foi por esse motivo que resolvi inicialmente esboçar o aplicativo em papel, para assim que eu pudesse ficar mais confortável com o que seria codificado tendo uma visão holística do projeto.

![Prototipação em papel](https://github.com/almeidaws/githubissues/blob/master/prototipo_papel.jpg?raw=true)

## Prototipação com Adobe XD

Após a etapa de prototipação no papel, parti para um recurso que me permitisse entender o funcionamento da solução com com um nível maior de detalhes. Como o foco é na base do código, não houve uma grande preocupação com UI, porém ainda sim é possível notar um cuidado pela aplicação de conceitos de  UX.

Note que as informações mais importantes como o título da issue e a sua situação atual, variável entre aberto e fechado, são mais chamativas que informações secundárias como a sua data de criação ou seu número identificador.

![Prototipação Adobe XD](https://github.com/almeidaws/githubissues/blob/master/prototipo_adobe_xd.png?raw=true)

Apesar disso, ainda assim há alguns problemas não solucionados como, por exemplo, o fato de como apresentar o título grande de uma issue sem deixar a tela visualmente poluída.

# Dificuldades

Ao começar esse projeto, eu nunca tinha usado o Swinject, apenas conhecia brevemente o mecanismo de Injeção de Dependência do [Vapor](https://vapor.codes) utilizando a framework [Service](https://docs.vapor.codes/3.0/service/getting-started). Além disso, também nunca havia usando o [Moya](https://github.com/Moya/Moya).

Mesmo assim, a falta desse conhecimento não foi um obstáculo, apenas um contratempo. Utilizando o [CBL](https://www.challengebasedlearning.org/) pude estudá-las e aplicá-las efetivamente no projeto. Certamente não é a melhor implementação, mas com certeza as boas práticas foram seguidas.

# Scrum

Apesar de que durante a execução desse projeto não houve a execução à risca dos rituais do Scrum, fiz questão de utilizar essa framework na *medida certa*, tomando notas das coisas que precisariam serem feitas. Isso me ajudou a manter a visão macro do projeto e me orientar durante o seu desenvolvimento.

![Tarefas](https://github.com/almeidaws/githubissues/blob/master/tarefas.png?raw=true)

# Programação
## Programação Orientada a Objeto
Apesar do Swift ser uma linguagem híbrida, todo o ecossistema do iOS foi pensando de forma orientada primariamente a objetos, por isso, seu uso foi feito intensivamente seguindo os princípios SOLID, principalmente o Princípio da Responsabilidade Única.

Porém, como os princípios são diretrizes e não leis, sua aplicação foi ponderada para evitar introduzir complexidade no projeto por excessos de abstrações.

Este é um exemplo de código que poderia ser generalizado, mas não foi para evitar *Otimização Prematura*.
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



## Programação Orientada a Protocolo
A programação orientada a protocolos materializou-se no uso extensivo de protocolos para definição de APIs e diminuição do acoplamento entre as entidades. Não houve grande oportunidade para o uso de recursos mais avançados como [Protocol Composition](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID282) ou [Protocol Extensions](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521).

## Programação Orientada a Valor
Foi feito um forte uso desse paradigma na definição das entidades de modelo. Elas são *structs* para evitar que uma instância do modelo seja compartilhada com outras instâncias, geralmente *view controllers*, diminuindo assim efeitos colaterais no programa e consequentemente evitando que bugs aconteçam, devido ao compartilhamento de estado.


# Possíveis melhorias
- Internacionalização e localização
- Acessibilidade
- Armazenamento dos dados para acesso offline
- Barra de pesquisa
- Filtragem da listagem

# Autor
[Gustavo Almeida](http://github.com/almeidaws)
