puts 'Cleaning database...'
Broker.destroy_all
Asset.destroy_all
puts 'OK'.green

puts 'Creating Brokers...'
Broker.create!(name: 'XP Investimentos', email: 'xp@email.com', password: '123456')
Broker.create!(name: 'Rico Investimetnos', email: 'rico@email.com', password: '123456')
puts 'OK'.green

# full_name code main_activities:text
puts 'Creating Assets...'
Asset.create!(full_name: 'AMBEV S/A ON', code: 'ABEV3',
              main_activities: 'Fabricação e Distribuição de Cervejas, Refrigerantes e Bebidas Não Carbonatadas e Não Alcoólicas')
Asset.create!(full_name: 'PETROBRAS PN', code: 'PETR4', main_activities: 'Petróleo, Gás e Energia')
Asset.create!(full_name: 'VALE PNA', code: 'VALE5', main_activities: 'Mineração')
Asset.create!(full_name: 'ITAUUNIBANCO PN', code: 'ITUB4', main_activities: 'Atividade Bancária')
Asset.create!(full_name: 'BRADESCO PN', code: 'BBDC4', main_activities: 'Atividade Bancária')
Asset.create!(full_name: 'BRASIL ON', code: 'BBAS3', main_activities: 'Atividade Bancária')
Asset.create!(full_name: 'CIELO ON', code: 'CIEL3', main_activities: 'Serviços de Adquirência e Meios de Pagamento')
Asset.create!(full_name: 'HYPERMARCAS ON', code: 'HYPE3', main_activities: 'Bens de consumo de Medicamentos')
Asset.create!(full_name: 'BBSEGURIDADE ON', code: 'BBSE3',
              main_activities: 'Operações de Seguros, Resseguros, Previdência e Capitalização')
Asset.create!(full_name: 'CETIP ON', code: 'CTIP3', main_activities: 'Administração de Mercados de Balcão Organizados')
Asset.create!(full_name: 'GERDAU PN', code: 'GGBR4', main_activities: 'Participação e Administração')
Asset.create!(full_name: 'RAIADROGASIL ON', code: 'RADL3',
              main_activities: 'Comércio de Produtos Farmacêuticos, Perfumaria e Afins.')
puts 'OK'.green
puts 'DONE'.green
