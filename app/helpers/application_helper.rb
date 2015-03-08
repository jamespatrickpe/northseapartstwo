module ApplicationHelper

  def rendercorepartial(partialname,partialinks={})
    render(:partial => "core_partials/"+partialname, :locals => partialinks)
  end

  def renderItemListerButtons(description,add,minus)
    rendercorepartial("itemlisterbuttons",{ :description => description, :add => add, :minus => minus})
  end

  def error_messages_for(object)
    render(:partial => "core_partials/formerrors", :locals => {:object => object})
  end

  def generateRandomString()
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...64).map { o[rand(o.length)] }.join.downcase!
  end

end
