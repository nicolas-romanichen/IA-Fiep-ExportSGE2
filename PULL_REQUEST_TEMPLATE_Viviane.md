# Defesa de Arquitetura de Software — Pull Request

## Nome do Avaliador Viviane Catanio
- **Nome do Estudante:** Leonardo Figura
- **Artefato(s) de Responsabilidade:** [ex: C4 Nível 3, Diagrama de Sequência e ADR 0001]

## O que este PR introduz na Documentação Viva?
Descreva sucintamente as alterações e os novos modelos adicionados à pasta `/docs/`:
- [ ] **Visão Funcional / Estrutural:** Diagrama de Casos de Uso ou Diagrama de Classes e Interfaces.
- [ ] **Visão Comportamental:** Diagrama de Sequência, Atividades (com Raias/Fork-Join) ou Máquina de Estados.
- [X] **Visão Arquitetural Macro:** Modelo C4 (L1, L2 ou L3 em Structurizr DSL, D2 ou PlantUML).
- [ ] **Governança:** Registros de Decisão Arquitetural (ADR).

## Defesa das Decisões de Design (Justificativa Técnica)
Explique a fundamentação técnica das decisões tomadas neste artefato:
1. **Escolha de Abstrações e Desacoplamento:** Por que as interfaces, visibilidades e relacionamentos foram desenhados dessa forma?
**R:** A arquitetura foi dividida em contêineres com responsabilidades específicas, seguindo o princípio da separação de responsabilidades.
A interface foi separada do backend para permitir que a comunicação com o usuário aconteça independentemente das regras de negócio. O backend atua como orquestrador, conectando os serviços de embeddings, banco vetorial, repositório de regras e modelo de linguagem (LLM).
O banco vetorial foi separado do repositório de regras aduaneiras porque possuem finalidades diferentes: o primeiro permite buscas por similaridade semântica, enquanto o segundo mantém os dados normativos estruturados.Essa organização facilita a manutenção, os testes e futuras expansões do sistema, permitindo substituir ou atualizar componentes sem comprometer toda a aplicação.

2. **Dinâmica e Resiliência:** Como os fluxos alternativos (`alt/else`), mensagens assíncronas ou guardas de estado tratam falhas no sistema?
**R:** A arquitetura prevê mecanismos para manter a confiabilidade das informações e facilitar a identificação de possíveis falhas.
O registro de auditoria funciona de maneira assíncrona, permitindo armazenar perguntas, fontes utilizadas e respostas sem bloquear o fluxo principal de atendimento.
O processo de atualização normativa permite que o curador regulatório revise e aprove alterações antes que elas sejam incorporadas ao repositório de regras e ao banco vetorial.
Caso uma atualização apresente problemas, é importante que a versão anterior das regras permaneça disponível até que a nova versão seja validada.Além disso, a integração com o Siscomex foi identificada como funcionalidade futura, evitando dependências externas na primeira versão do sistema.

3. **Trade-offs:** Quais prós e contras foram considerados no momento da modelagem?
**R:** As principais vantagens da arquitetura são:
- Organização dos componentes em responsabilidades independentes.
- Facilidade de manutenção e evolução do sistema.
- Possibilidade de atualização das normas sem modificar toda a aplicação.
- Maior rastreabilidade das respostas por meio dos registros de auditoria.
- Utilização de inteligência artificial com recuperação de informações normativas.
- Facilidade para adicionar futuras integrações governamentais.
- 
As principais desvantagens e desafios são:
- Maior complexidade de desenvolvimento devido à quantidade de componentes.
- Necessidade de manter o banco vetorial sincronizado com o repositório normativo.
- Custos relacionados à utilização de modelos de linguagem e serviços de embeddings.
- Dependência da qualidade e atualização das fontes normativas.
- Possibilidade de respostas incorretas ou incompletas geradas pela inteligência artificial.
A decisão foi priorizar uma arquitetura modular, organizada e preparada para expansão, mesmo que isso aumente a complexidade inicial do desenvolvimento.

## Consistência Cross-Diagramas (Checklist de Autoverificação)
Antes de solicitar a revisão de um colega, confirme o alinhamento entre os modelos:
- [X] Os nomes de métodos chamados no Diagrama de Sequência existem nas interfaces do Diagrama de Classes.
- [X] Os contêineres e componentes citados correspondem exatamente à nomenclatura do Modelo C4 L2/L3.
- [X] As transições de estado refletem os gatilhos disparados pelas atividades da aplicação.

## Validação da Sintaxe Diagrams-as-Code / Models-as-Code
- **Ferramenta de Compilação/Renderização Utilizada:** D2 (Diagrams as Code).
**R:** O diagrama foi estruturado utilizando elementos gráficos, classes, contêineres, bancos de dados e relacionamentos. A utilização do D2 permite representar a arquitetura por meio de código, facilitando alterações, manutenção e versionamento da documentação.
  
- **Status da Compilação:** [X] Código limpo e sem erros de sintaxe ao renderizar.
