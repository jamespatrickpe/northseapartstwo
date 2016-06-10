class GeneralAdministration::ImportContactsWizardController < GeneralAdministrationController

  include Wicked::Wizard

  steps :upload_excel,
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

          system_actor_count = 0
          address_count = 0
          digital_count = 0
          telephone_count = 0

          primary_sheet.each(system_account: 'system_account',
                             category: 'category',
                             address: 'address',
                             digital: 'digital',
                             telephone: 'telephone') do |hash,index|

            unless hash[:system_account] == "system_account"

              "\n -- ROW BEGIN -- \n"
              puts hash.inspect

              raw_system_actor = (hash[:system_account]).to_s
              raw_category = (hash[:category]).to_s
              raw_address = (hash[:address]).to_s
              raw_digital = (hash[:digital]).to_s
              raw_telephone = (hash[:telephone]).to_s
              raw_latitude = (hash[:latitude])
              raw_longitude = (hash[:longitude])

              my_system_actor = SystemAccount.new
              my_system_actor[:name] = extract_field_value(raw_system_actor)
              my_system_actor[:remark] = extract_field_remark(raw_system_actor) + ' '+ raw_category.to_s
              my_system_actor.save!
              system_actor_count += 1

              unless raw_address.nil?
                raw_address.split(";").each do |address|
                  my_address = Address.new
                  my_address[:remark] = address.lstrip.rstrip
                  my_address[:latitude] = raw_latitude.to_i
                  my_address[:longitude] = raw_longitude.to_i
                  my_address[:addressable_id] = my_system_actor.id
                  my_address[:addressable_type] = SystemAccount
                  my_address.save!
                  address_count+=1
                end
              end

              unless raw_digital.nil?
                raw_digital.split(";").each do |digital|
                  my_digital = Digital.new
                  my_digital[:url] = extract_field_value(digital)
                  my_digital[:remark] = extract_field_remark(digital)
                  my_digital[:digitable_id] = my_system_actor.id
                  my_digital[:digitable_type] = SystemAccount
                  my_digital.save!
                  digital_count+=1
                end
              end

              unless raw_telephone.nil?
                raw_telephone.split(";").each do |telephone|
                  my_telephone = Telephone.new
                  my_telephone[:digits] = extract_field_value(telephone)
                  my_telephone[:remark] = extract_field_remark(telephone)
                  my_telephone[:telephonable_id] = my_system_actor.id
                  my_telephone[:telephonable_type] = SystemAccount
                  my_telephone.save!
                  telephone_count+=1
                end
              end

              puts "\n -- ROW COMPLETE -- \n"

            end

          end
        rescue => ex
          puts ex
          puts ex.backtrace
        end

      when :show_results

    end

    redirect_to next_wizard_path +
                    "?system_account_count=" +
                    system_actor_count.to_s +
                    "&address_count=" +
                    address_count.to_s +
                    "&digital_count=" +
                    digital_count.to_s +
                    "&telephone_count=" +
                    telephone_count.to_s
  end

  def extract_field_remark(current_string)
    (current_string[/(\[.*?\])/]).to_s.gsub('[','').gsub(']','').lstrip.rstrip
  end

  def extract_field_value(current_string)
    current_string.gsub(/(\(|\[).+(\)|\])/, '').lstrip.rstrip
  end


end

