class Item < ActiveRecord::Base
	belongs_to :flux

  default_scope order('created_at DESC')

  # Est-ce que l'item est lu ? On renvoie la valeur de la comparaison entre le status et "lu".
  # Par convention les méthodes qui interroge un objet pour savoir si un attribut est rempli se terminent par ?
  # Mais on peut aussi utiliser le ? où on trouve que c'est parlant (Ex: user.admin?)
  # On aurait pu écrire "return status == 'lu'", mais en Ruby le résultat de la dernière ligne fait office de return, donc ici pas besoin.
  def read?
    status == 'lu'
  end

  # Par convention les méthodes avec un bang ! à la fin sont les méthodes qui modifient l'objet auquel elles appartiennent.
  # Ainsi les méthodes read! et unread! vont mettre à jour l'attribut status de l'item
  # Ex: item = Item.new
  #     item.status  # => nil
  #     item.read!   # => true
  #     item.status  # => 'lu'
  #     item.unread! # => true
  #     item.status  # => 'non lu'

  # On met à jour l'item pour le marquer comme lu
  def read!
    self.update_attributes(:status => 'lu')
  end

  # On met à jour l'item pour le marquer comme non lu
  def unread!
    self.update_attributes(:status => 'non lu')
  end

end
