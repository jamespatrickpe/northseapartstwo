class GeneralAdministration::ContactDetailsController < GeneralAdministrationController

  def index

    search = Actor.search do
      fulltext "Ventus"
    end

    @my_results = search.results

  end

end