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

        xlsx = Roo::Spreadsheet.open(params[wizard_path][:file])
        primary_sheet = xlsx.sheet(0)
        primary_sheet.each(system_actor_name: 'system_actor_name',
                           system_actor_remark: 'system_actor_remark',
                           telephone_digits: 'telephone_digits',
                           telephone_remark: 'telephone_remark',
                           digital: 'digital',
                           digital_remark: 'digital_remark',
                           address_remark: 'address_remark' ) do |hash,index|


          unless index == 1
            my_system_actor = SystemActor.new
            my_system_actor[:name] = hash[:system_actor_name]
            my_system_actor[:remark] = hash[:system_actor_remark]
            my_system_actor.save!
          end

          puts hash

        end
      when :show_results
    end
    render_wizard

  end

end
