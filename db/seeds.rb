# db/seeds.rb

puts "Limpando banco..."

Attachment.destroy_all
Comment.destroy_all
Issue.destroy_all
Node.destroy_all
Workspace.destroy_all

puts "Criando workspace..."

workspace = Workspace.create!(
  name: "Vista 553",
  description: "Gestão operacional, obras, pendências e administração do condomínio"
)

puts "Criando nodes principais..."

areas_comuns = workspace.nodes.create!(
  name: "Áreas Comuns",
  node_type: "category",
  description: "Gestão das áreas comuns do condomínio"
)

apartamentos = workspace.nodes.create!(
  name: "Apartamentos",
  node_type: "category",
  description: "Estrutura de apartamentos do empreendimento"
)

obras = workspace.nodes.create!(
  name: "Obras e Pendências da Construtora",
  node_type: "category",
  description: "Pendências, defeitos e obras da construtora"
)

administracao = workspace.nodes.create!(
  name: "Administração e Condomínio",
  node_type: "category",
  description: "Temas administrativos e operacionais"
)

seguranca = workspace.nodes.create!(
  name: "Segurança",
  node_type: "category",
  description: "Controle de acesso, câmeras e segurança"
)

infraestrutura = workspace.nodes.create!(
  name: "Infraestrutura",
  node_type: "category",
  description: "Sistemas de infraestrutura do condomínio"
)

assembleias = workspace.nodes.create!(
  name: "Assembleias e Decisões",
  node_type: "category",
  description: "Decisões coletivas e assembleias"
)

fornecedores = workspace.nodes.create!(
  name: "Fornecedores",
  node_type: "category",
  description: "Prestadores de serviço e fornecedores"
)

puts "Criando nodes de Áreas Comuns..."

[
  "Academia",
  "Piscina",
  "Hall",
  "Garagem",
  "Portaria",
  "Espaço Gourmet",
  "Elevadores",
  "Fachada"
].each do |area|
  areas_comuns.children.create!(
    workspace: workspace,
    name: area,
    node_type: "location"
  )
end

puts "Criando nodes de Obras e Pendências..."

[
  "Pintura",
  "Elétrica",
  "Hidráulica",
  "Fachada",
  "Paisagismo",
  "Acabamentos",
  "Garagem",
  "Áreas Comuns"
].each do |tema|
  obras.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "topic"
  )
end

puts "Criando nodes de Administração..."

[
  "Administradora",
  "Regras Internas",
  "Cadastro de Moradores",
  "Comunicação",
  "Controle Financeiro",
  "Mudanças",
  "Prestação de Contas"
].each do |tema|
  administracao.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "process"
  )
end

puts "Criando nodes de Segurança..."

[
  "Câmeras",
  "Controle de Acesso",
  "Portaria",
  "Tags e Biometria",
  "Iluminação Externa",
  "Alarmes"
].each do |tema|
  seguranca.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "system"
  )
end

puts "Criando nodes de Infraestrutura..."

[
  "Internet",
  "Interfone",
  "Energia",
  "Água",
  "Gás",
  "Bombas",
  "Gerador"
].each do |tema|
  infraestrutura.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "system"
  )
end

puts "Criando nodes de Assembleias e Decisões..."

[
  "Envidraçamento da Sacada",
  "Regras de Reforma",
  "Pets",
  "Uso das Áreas Comuns",
  "Segurança"
].each do |tema|
  assembleias.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "decision"
  )
end

puts "Criando nodes de Fornecedores..."

[
  "Construtora",
  "Administradora",
  "Empresa de Segurança",
  "Internet",
  "Paisagismo",
  "Limpeza"
].each do |tema|
  fornecedores.children.create!(
    workspace: workspace,
    name: tema,
    node_type: "vendor"
  )
end

puts "Criando estrutura de apartamentos..."

(4..25).each do |andar|
  andar_node = apartamentos.children.create!(
    workspace: workspace,
    name: "#{andar}º Andar",
    node_type: "floor"
  )

  (1..12).each do |unidade|
    numero_apto = "#{andar}#{format('%02d', unidade)}"

    andar_node.children.create!(
      workspace: workspace,
      name: "Apartamento #{numero_apto}",
      node_type: "unit",
      description: "Unidade residencial #{numero_apto}"
    )
  end
end

puts "Criando issues de exemplo..."

camera_node = Node.find_by(name: "Câmeras")

Issue.create!(
  workspace: workspace,
  node: camera_node,
  title: "Condomínio sem sistema de câmeras instalado",
  description: "Necessário definir orçamento e instalação do sistema de monitoramento.",
  status: :open,
  priority: :critical
)

envidracamento_node = Node.find_by(name: "Envidraçamento da Sacada")

Issue.create!(
  workspace: workspace,
  node: envidracamento_node,
  title: "Modelo de envidraçamento ainda não aprovado",
  description: "Assembleia precisa definir padrão oficial para instalação.",
  status: :open,
  priority: :high
)

apto_401 = Node.find_by(name: "Apartamento 401")

Issue.create!(
  workspace: workspace,
  node: apto_401,
  title: "Mal acabamento na pintura",
  description: "Parede da sala apresenta falhas e marcas de massa corrida.",
  status: :open,
  priority: :medium
)

puts "Seed finalizada com sucesso!"
puts "Workspace criado: #{workspace.name}"
puts "Total de nodes: #{Node.count}"
puts "Total de issues: #{Issue.count}"
