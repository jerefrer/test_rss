class RssValidator < ActiveModel::Validator


	def validate(record)
		#verifie que l'url cotient le mot "rss"

		unless record.url =~ /rss/i
		record.errors[:url] << " n'est pas un lien rss valide."
		end
		
		#open(lien) do |rss|
		#  feed = RSS::Parser.parse(rss)
			
		#	if feed.items.length <= 0
		#		record.errors[:url] << " L'url n'est pas un lien rss valide."
		#	end
		
		#end
	end
end