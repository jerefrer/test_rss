require 'rss_fetcher'

class Flux < ActiveRecord::Base

	has_many :items, :dependent => :destroy
	
	validates :titre, :url, :presence => { :message => "n'est pas rempli." }

  validates_with RssValidator # On utilise notre "custom validator"

  after_create :import_new_items

  def import_new_items
    # On utilise une classe spécifiqe pour créer les items.
    # On fait ça pour garder notre modèle léger et facile à lire, et parce que récupérer des données depuis un flux RSS est plutôt
    # quelque chose lié à une librairie externe plutôt qu'à notre objet Flux stocké en base de donnée
    # On place notre RssFetcher dans le dossier lib/, où on place toutes nos classes qui n'ont rien à voir avec la base de donnée
    RssFetcher.new(self).fetch!
  end

end
