# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Criando núcleos..."
Core.delete_all
Core.create(name: "Núcleo de Organização Empresarial", description: "ADMFIN + Presorg", initial: "NOE")
Core.create(name: "Núcleo de Atendimento e Vendas", description: "Negociadores", initial: "NAV")
Core.create(name: "Núcleo de Imagem e Publicidade", description: "Marketing", initial: "NIP")
Core.create(name: "Núcleo de Desenvolvimento e Pesquisa", description: "Projetos", initial: "NDP")
Core.create(name: "Núcleo de Talentos", description: "RH", initial: "NUT")
Core.create(name: "Presidência", description: "Presidente", initial: "PRS")
puts "Núcleos criados."
puts "Criando Cargos..."
Occupation.delete_all
Occupation.create(name: "Consultor de Organização Empresarial", description: "consultor")
Occupation.create(name: "Consultor de Atendimento e Vendas", description: "consultor")
Occupation.create(name: "Consultor de Imagem e Publicidade", description: "consultor")
Occupation.create(name: "Consultor de Desenvolvimento e Pesquisa", description: "consultor")
Occupation.create(name: "Consultor de Talentos", description: "consultor")

Occupation.create(name: "Coordenador Organizacional", description: "consultor")
Occupation.create(name: "Coordenador de Operações", description: "consultor")

Occupation.create(name: "Diretor de Talentos", description: "diretor", is_admin: true)
Occupation.create(name: "Diretor de Organização Empresarial", description: "diretor", is_admin: true)
Occupation.create(name: "Diretor de Desenvolvimento e Pesquisa", description: "diretor", is_admin: true)
Occupation.create(name: "Diretor de Atendimento e Vendas", description: "diretor", is_admin: true)
Occupation.create(name: "Diretor de Imagem e Publicidade", description: "diretor", is_admin: true)
Occupation.create(name: "Presidente", description: "presidente", is_admin: true)
puts "Cargos criados."
Role.delete_all
puts "Criando roles..."
Role.create(name: "Gerente", description: "Gerente do projeto")
Role.create(name: "Negociador", description: "Negociador do Projeto")
Role.create(name: "Desenvolvedor", description: "Desenvolvedor do Projeto")
puts "Roles criados."

Goal.delete_all
puts "Criando metas..."
Goal.create(name: "Projetos", description: "Número total de projetos", value: 23)
Goal.create(name: "Faturamento", description: "Faturamento total da empresa", value: 100000.00)
Goal.create(name: "NPS", description: "Net Promoter Score", value: 90)
puts "Metas criadas."

puts "Criando setup inicial..."
Setup.delete_all
Setup.create(weekly_hours: 12, superdidgood_price: 100)
puts "Setup inicial criado."
puts "Criando user..."
puts "User criado."
