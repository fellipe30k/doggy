# db/seeds.rb
# Criar company padrão
Company.destroy_all
User.destroy_all
Animal.destroy_all
Vaccination.destroy_all
puts "🌱 Limpando dados antigos..."
company = Company.create!(
  name: 'Clínica Veterinária Demo',
  cnpj: '12.345.678/0001-90',
  address: 'Rua das Flores, 123',
  phone: '11999999999',
  email: 'contato@clinicademo.com',
  active: true
)

# Criar usuário admin
admin = User.create!(
  email: 'admin@clinicademo.com',
  password: 'password123',
  first_name: 'Admin',
  last_name: 'Clinic',
  phone: '11888888888',
  role: 'admin',
  company: company,
  active: true
)

puts "✅ Dados iniciais criados com sucesso!"
puts "🏥 Company: #{company.name}"
puts "👤 Admin: #{admin.email}"
puts "🔑 Senha: password123"