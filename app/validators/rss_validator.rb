# On require une fois pour toute nos dépendances, ainsi elles sont chargées une seule fois : au lancement du serveur (donc à l'instantiation de nos classes)
require 'open-uri'
require 'rss'

class RssValidator < ActiveModel::Validator

  def validate(record)
    url = record.url
    url = record.url = 'http://' + url unless url =~ /^http:\/\// # On ajoute http:// devant l'url si ce n'est pas déjà le cas
    # Ici on se sert d'un bloc begin/rescue pour récupérer les erreurs éventuelles que renverrait open(url) en parsant une URL invalide
    begin
      open(url) do |rss|
        # Ici on se sert d'un bloc begin/rescue pour récupérer les erreurs éventuelles que renverrait RSS::Parser.parse en parsant une URL qui ne pointe pas vers un flux RSS
        begin
          feed = RSS::Parser.parse(rss)
        rescue
          record.errors[:url] << " L'url n'est pas celle d'un flux RSS."
        end
      end
    rescue
      record.errors[:url] << " L'url n'est valide."
    end
  end

end