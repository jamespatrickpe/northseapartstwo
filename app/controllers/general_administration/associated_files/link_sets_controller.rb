class GeneralAdministration::AssociatedFiles::LinkSetsController < GeneralAdministration::AssociatedFilesController

  def index
    initialize_generic_index(LinkSet, 'Link Sets')
  end

  def search_suggestions
    simple_singular_column_search('link_sets.url',LinkSet)
  end

  def new
    set_new_edit(LinkSet)
  end

  def edit
    set_new_edit(LinkSet)
  end

  def show
    edit
  end

  def delete
    generic_delete(LinkSet)
  end

  def process_form(myLinkSet)
    begin
      myLinkSet[:url] = params[controller_path][:url]
      myLinkSet[:remark] = params[controller_path][:remark]
      myLinkSet[:linksetable_type] = params[controller_path][:linksetable_type]
      myLinkSet[:linksetable_id] = params[controller_path][:linksetable_id]
      myLinkSet.save!
      set_process_notification
    rescue => ex
      index_error(ex)
    end
    redirect_to_index
  end

  def create
    process_form(LinkSet.new())
  end

  def update
    process_form(LinkSet.find(params[controller_path][:id]))
  end

end