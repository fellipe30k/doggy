# app/helpers/animals_helper.rb
module AnimalsHelper
  # Helper para link da carteirinha com ícone
  def vaccination_card_link(animal, format: 'portrait', options: {})
    default_options = {
      class: "inline-flex items-center justify-center px-3 py-2 bg-purple-100 dark:bg-purple-950/50 hover:bg-purple-200 dark:hover:bg-purple-900/50 text-purple-700 dark:text-purple-300 text-sm font-medium rounded-lg transition-colors",
      target: "_blank"
    }
    
    merged_options = default_options.merge(options)
    
    link_to vaccination_card_animal_path(animal, format: format), merged_options do
      concat content_tag(:svg, class: "w-4 h-4 mr-1", fill: "currentColor", viewBox: "0 0 24 24") do
        content_tag(:path, nil, d: "M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z")
      end
      concat "Carteirinha"
    end
  end
  
  # Helper para determinar se animal tem dados suficientes para carteirinha
  def animal_ready_for_card?(animal)
    animal.name.present? && 
    animal.species.present? && 
    animal.birth_date.present? && 
    animal.weight.present?
  end
  
  # Helper para contar vacinações em dia vs atrasadas
  def vaccination_status_summary(animal)
    total = animal.vaccinations.count
    overdue = animal.vaccinations.select(&:overdue?).count
    up_to_date = total - overdue
    
    {
      total: total,
      up_to_date: up_to_date,
      overdue: overdue,
      percentage_complete: total > 0 ? (up_to_date.to_f / total * 100).round : 0
    }
  end
  
  # Helper para próxima vacina vencendo
  def next_vaccination_due(animal)
    animal.vaccinations
           .where('next_dose_date IS NOT NULL AND next_dose_date >= ?', Date.current)
           .order(:next_dose_date)
           .first
  end
  
  # Helper para idade formatada
  def formatted_age(animal)
    return "Idade não informada" unless animal.birth_date
    
    age_years = animal.age_in_years
    age_months = ((Date.current - animal.birth_date) / 30.44).round
    
    if age_years >= 1
      "#{age_years} #{age_years == 1 ? 'ano' : 'anos'}"
    elsif age_months >= 1
      "#{age_months} #{age_months == 1 ? 'mês' : 'meses'}"
    else
      days = (Date.current - animal.birth_date).to_i
      "#{days} #{days == 1 ? 'dia' : 'dias'}"
    end
  end
end

# app/helpers/application_helper.rb - ADICIONAR helpers globais
module ApplicationHelper
  # Helper para formatar telefone brasileiro
  def format_phone(phone)
    return phone unless phone.present?
    
    # Remove tudo que não é número
    numbers = phone.gsub(/\D/, '')
    
    case numbers.length
    when 10
      # Formato: (11) 9999-9999
      "(#{numbers[0,2]}) #{numbers[2,4]}-#{numbers[6,4]}"
    when 11
      # Formato: (11) 99999-9999
      "(#{numbers[0,2]}) #{numbers[2,5]}-#{numbers[7,4]}"
    else
      phone # Retorna original se não conseguir formatar
    end
  end
  
  # Helper para formatar CNPJ
  def format_cnpj(cnpj)
    return cnpj unless cnpj.present?
    
    numbers = cnpj.gsub(/\D/, '')
    return cnpj unless numbers.length == 14
    
    "#{numbers[0,2]}.#{numbers[2,3]}.#{numbers[5,3]}/#{numbers[8,4]}-#{numbers[12,2]}"
  end
  
  # Helper para status da vacinação com cor
  def vaccination_status_badge(vaccination)
    if vaccination.overdue?
      content_tag :span, "Atrasada", 
        class: "inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-red-100 dark:bg-red-950/50 text-red-700 dark:text-red-300"
    elsif vaccination.next_dose_date && vaccination.next_dose_date <= 30.days.from_now
      content_tag :span, "Próxima", 
        class: "inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-yellow-100 dark:bg-yellow-950/50 text-yellow-700 dark:text-yellow-300"
    else
      content_tag :span, "Em dia", 
        class: "inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 dark:bg-green-950/50 text-green-700 dark:text-green-300"
    end
  end
  
  # Helper para ícone do status do animal
  def animal_status_icon(animal)
    status = vaccination_status_summary(animal) if respond_to?(:vaccination_status_summary)
    
    if status && status[:overdue] > 0
      "⚠️" # Vacinas atrasadas
    elsif status && status[:total] == 0
      "❗" # Sem vacinações
    else
      "✅" # Tudo em dia
    end
  end
  
  # Helper para cor do tema baseado no status
  def status_color_class(status)
    case status
    when 'success', 'active', 'up_to_date'
      'text-green-600 dark:text-green-400'
    when 'warning', 'pending', 'due_soon'
      'text-yellow-600 dark:text-yellow-400'  
    when 'danger', 'overdue', 'inactive'
      'text-red-600 dark:text-red-400'
    else
      'text-stone-600 dark:text-stone-400'
    end
  end
end

