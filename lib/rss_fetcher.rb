# On require une fois pour toute nos dépendances, ainsi elles sont chargées une seule fois : au lancement du serveur (donc à l'instantiation de nos classes)
require 'rss'
require 'open-uri'

class RssFetcher

  def initialize(flux)
    @flux = flux # @flux est un attribut de la classe, une fois un object instancié on peut donc l'appeler partout. C'est le cas dans fetch!
  end

  def fetch!
    first_import = @flux.items.empty? # Si le flux n'a encore aucun item alors on récupère tous les items, qu'ils soient plus vieux que la date du jour ou non
    open(@flux.url) do |rss| # Ici url fait référence à l'attribut url de l'objet Flux (puisqu'on est dans une méthode de la classe Flux). On aurait aussi pu écrire "open(self.url) do |rss|"
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        # On ne récupère que les items qui sont plus récent que le plus récent des items du flux
        # On peut remarquer qu'on utilise ici le if à la fin de la ligne, ça évite de faire un if ... end sur 3 lignes
        @flux.items.create(:titre => item.title, :contenu => item.description, :date => item.pubDate, :status => 'non lu') if first_import || item.pubDate > @flux.items.first.created_at
      end
    end
  end

end