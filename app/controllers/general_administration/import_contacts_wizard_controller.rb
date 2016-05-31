class GeneralAdministration::ImportContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :upload_excel
        :show_results

  def show

    case step
      when :upload_excel
      when :show_results
    end
    render_wizard

  end

  def update
    require 'roo'

    case step
      when :upload_excel
        begin

          xlsx = Roo::Spreadsheet.open(params[wizard_path][:file])
          primary_sheet = xlsx.sheet(0)
          primary_sheet.each(system_actor: 'system_actor',
                             category: 'category',
                             address: 'address',
                             digital: 'digital',
                             telephone: 'telephone') do |hash,index|

            raw_system_actor = hash[:system_actor]
            raw_category = hash[:category]
            raw_address = hash[:address]
            raw_digital = hash[:digital]
            raw_telephone = hash[:telephone]

            my_system_actor = SystemActor.new
            my_system_actor[:name] = extract_field_value(raw_system_actor)
            my_system_actor[:name] = extract_field_remark(raw_system_actor)
            my_system_actor.save!
            
            end
        rescue => ex
          puts ex
        end
      when :show_results
    end
    render_wizard
  end

  def extract_field_remark(current_string)
    (current_string[/(\[.*?\])/]).to_s.gsub('[','').gsub(']','').lstrip.rstrip
  end

  def extract_field_value(current_string)
    current_string.gsub(/(\(|\[).+(\)|\])/, '').lstrip.rstrip
  end


end

