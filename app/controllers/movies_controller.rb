class MoviesController < ApplicationController
  def initialize
    @genres = ['Action','Animation','Comedy','Documentary','Horror','Musical','Sport']
    @lists = ['Top Rated', 'Most Popular', 'Recent','Classic']
  end
  def index
      @data = []
      Movie.order("RANDOM()").limit(10).each do |m|
        #p m
     @data.push({'id': m['id'],'title': m['title'], 'image': m['image'], 
                  'year': m['year'], 'is_tv': m['is_tv'],'rating': m['rating'],
                   'gen': @genres,'episodes': m['episodes'],'plot': m['plot'], 'lists': @lists})
      end
      # GET ACTORS
      # for page in (1..10).step(1) do
      # movies = RestClient.get("https://moviesdatabase.p.rapidapi.com/titles?list=most_pop_series&page=#{page}&info=base_info&limit=50", headers= {	"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"})
      # movies_json = JSON.parse(movies.to_s)['results'].each do |series|
      #   p series
      #   if Movie.where(movie_id: series['id']).exists? then next end
      #     year = series['releaseYear'] == nil ? nil : series['releaseYear']['year']
      #     rating = series['ratingsSummary'] == nil ? 0 : series['ratingsSummary']['aggregateRating']
      #     eps = series['episodes'] == nil ? 'Unknown' : series['episodes']['totalEpisodes']['total']
      #     genre = series['genres'] == nil ? nil : series['genres']['genres'][0]['text']
      #     plot = series['plot'] == nil ? nil : series['plot']['plotText']['plainText']
      #     Movie.create('movie_id': series['id'],'title': series['titleText']['text'], 'image': series['primaryImage']['url'], 
      #     'year': year, 'rating': rating, 'episodes': eps, 'plot': plot, 'genre': genre, 
      #     'is_tv': series['titleType']['isSeries'], 'list': 'most_pop_series')
      # #for m in (1..Movie.count).step(1)
      #   #movie_ids = Movie.find(m).movie_id
      #   #if movie_ids.nil? then next end
      #   query = RestClient.get("https://moviesdatabase.p.rapidapi.com/titles/x/titles-by-ids?idsList=#{series['id']}&info=extendedCast", headers= {	"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"})
      #   JSON.parse(query.to_s)['results'][0]['cast']['edges'].each do |cast|
      #     movie_id = Movie.where(movie_id: series['id']).first.id
      #     if ActorMovie.where(movie_id:movie_id).exists?
      #       actorid_check = ActorMovie.where(movie_id:movie_id).first.actor_id
      #       if Actor.where(id:actorid_check).exists?
      #         'actor exists'
      #         next 
      #       end
      #     end
      #     actor = cast['node']['name']['nameText']['text']
      #     if cast['node']['name']['primaryImage'].nil?
      #       p 'no image' 
      #       next 
      #     end
      #     pic = cast['node']['name']['primaryImage']['url']
      #     actor_record = Actor.where(picture:pic)
      #     if actor_record.exists?
      #       p 'getting actor id'
      #       actor_id = actor_record.first.id
      #     else
      #       p 'creating actor'
      #       a = Actor.create(name:actor, picture:pic)
      #       actor_id = a.id
      #     end
      #     p [actor_id,movie_id]
      #     p 'creation asociation'
      #     ActorMovie.create(actor_id: actor_id, movie_id: movie_id)
      #   end
      # end
      # end
    #GET APPS
    #   Movie.all.each do |i|
    #     id = i['movie_id']
    #     p id
    #     if AppMovie.where(movie_id: i).exists? then next end
    #     if id.nil? then next end
    #     begin
    #     query = RestClient.get("https://streaming-availability.p.rapidapi.com/get?output_language=en&imdb_id=#{id}", headers= {	"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "streaming-availability.p.rapidapi.com"})
    #     rescue
    #       next
    #     end
    #     p JSON.parse(query.to_s)
    #     if JSON.parse(query.to_s)['result']['streamingInfo']['us'].nil? then next end
    #     JSON.parse(query.to_s)['result']['streamingInfo']['us'].each do |m|
    #     app = m['service']
    #     link = m['link']
    #       unless App.exists?('name': app)
    #         App.create('name': app)
    #       end
    #       AppMovie.create(app_id: App.where(name: app).first['id'], 
    #       movie_id: Movie.where(movie_id: id).first.id, link: link)
    #   end
    # end
  end

  def show
    mov = Movie.find(params[:id])
    movieid = mov.id
    availability = AppMovie.where('movie_id': movieid).map {|elem| {'app': App.find(elem.app_id).name, 'link': elem.link}}
    availability = availability.uniq {|elem| elem.first}
    cast = ActorMovie.where('movie_id': movieid).limit(3).map {|elem| {'name': Actor.find(elem.actor_id).name, 'pic': Actor.find(elem.actor_id).picture}}
    @data = {'id': mov.movie_id, 'title': mov.title, 'image': mov.image, 
    'year': mov.year, 'rating': mov.rating, 'episodes': mov.episodes, 'genre': mov.genre, 'plot': mov.plot, 
    'availability': availability, 'cast': cast, 'is_tv': mov.is_tv, 'gen':@genres, 'lists': @lists}
    # else
    #   query = RestClient.get("https://moviesdatabase.p.rapidapi.com/titles/x/titles-by-ids?idsList=#{params[:id]}&info=base_info", headers= {"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"})
    #   m = JSON.parse(query.to_s)['results'][0]
    #   p 'got query'
    #   begin
    #     availability = RestClient.get("https://streaming-availability.p.rapidapi.com/get?output_language=en&imdb_id=#{params[:id]}", headers= {"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "streaming-availability.p.rapidapi.com"}) 
    #   rescue
    #     availability = JSON.dump({'result':{'streamingInfo':{'us':nil}}})
    #   end
    #   a = JSON.parse(availability.to_s)['result']['streamingInfo']['us']
    #   apps = {}
    #   if a.nil?
    #     apps['result'] = nil
    #   else
    #     apps['result'] = a.uniq {|elem| elem.first}
    #   end
    #   p apps
    #   actors = RestClient.get("https://imdb-com.p.rapidapi.com/title/top-cast?tconst=#{params[:id]}", headers = {"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "imdb-com.p.rapidapi.com"})
    #   c = JSON.parse(actors.to_s)['data']
    #   p 'got actors'
    #   p 'cleaning'
    #   cast = {'result': c[0..2]}
    #   p cast
    #   year = m['releaseYear'] == nil ? nil : m['releaseYear']['year']
    #   rating = m['ratingsSummary'] == nil ? 0 : m['ratingsSummary']['aggregateRating']
    #   eps = m['episodes'] == nil ? 'Unknown' : m['episodes']['totalEpisodes']['total']
    #   genre = m['genres'] == nil ? nil : m['genres']['genres'][0]['text']
    #   plot = m['plot'] == nil ? nil : m['plot']['plotText']['plainText']
    #   if mov
    #     mov.update(genre: genre, availability: apps, cast:cast, is_tv: m['titleType']['isSeries'])
    #   else
    #     Movie.create('movie_id': m['id'],'title': m['title'], 'image': m['image'], 'year': m['year'], 
    #                   'rating': m['rating'], 'episodes': m['episodes'], 'plot': m['plot'],genre: genre,
    #                   availability: apps, cast:cast, is_tv: m['titleType']['isSeries'])
    #   end
    #   @data = {'id': m['id'], 'title': m['titleText']['text'], 'image': m['primaryImage']['url'], 
    #   'year': year, 'rating': rating, 'episodes': eps, 'genre': genre, 'plot': plot, 
    #   'availability': apps, 'cast': cast, 'is_tv': m['titleType']['isSeries'], 'gen': @genres}
    # end
  end

  def search
    query = params[:query]
    results = Movie.where('title LIKE ?',"%#{query}%")
    @data = []
    if results.empty? then
      query = query.split(' ').join('%20')
      call = RestClient.get("https://moviesdatabase.p.rapidapi.com/titles/search/title/#{query}?exact=false&info=base_info&titleType=tvSeries&limit=50", {"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"})
      response = JSON.parse(call.to_s)['results'].each do |m|
        if m['primaryImage'].nil? then next end
          p m
        genre = m['genres'].nil? ? nil : m['genres']['genres'][0]['text']
        plot = m['plot'].nil? ? nil : m['plot']['plotText']['plainText']
        episodes = m['episodes'].nil? ? nil : m['episodes']['episodes']['total']
        year = m['releaseYear'].nil? ? nil : m['releaseYear']['year']
        image = m['primaryImage']['url']
          Movie.create('movie_id': m['id'],'title': m['titleText']['text'], 'image': image, 
          'year': m['releaseYear']['year'], 'rating': m['ratingsSummary']['aggregateRating'], 
          'episodes': episodes, 'plot': plot, genre: genre ,is_tv: m['titleType']['isSeries'])
        @data.push({'id': Movie.where(image: image).first.id,'title': m['titleText']['text'], 'image': image, 
        'year': m['releaseYear']['year'], 'is_tv': m['titleType']['isSeries'],
        'caption': m['primaryImage']['caption']['plainText'], 'rating': m['ratingsSummary']['aggregateRating'],
        'gen': @genres, 'lists': @lists})
        # GET ACTORS
        actorsApi = RestClient.get("https://moviesdatabase.p.rapidapi.com/titles/x/titles-by-ids?idsList=#{m['id']}&info=extendedCast", headers= {	"X-RapidAPI-Key": "33884a2f76msh36de809da8af97ap1517a4jsna8e4b5dab5d1","X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"})
        JSON.parse(actorsApi.to_s)['results'][0]['cast']['edges'].each do |cast|
          movie_id = Movie.where(movie_id: m['id']).first.id
          actor = cast['node']['name']['nameText']['text']
          if cast['node']['name']['primaryImage'].nil?
            next 
          end
          pic = cast['node']['name']['primaryImage']['url']
          actor_record = Actor.where(picture:pic)
          if actor_record.exists?
            actor_id = actor_record.first.id
          else
            a = Actor.create(name:actor, picture:pic)
            actor_id = a.id
          end
          ActorMovie.create(actor_id: actor_id, movie_id: movie_id)
        end
      end
    else
    if results.length == 1
      redirect_to "/movies/show/#{results.first.id}"
    end
    results.each do |m|
      @data.push({'id': m[:id],'title': m[:title], 'image': m[:image], 'year': m[:year], 
      'is_tv': m[:is_tv],'caption': m[:image], 'rating': m[:rating], 'gen': @genres, 'lists': @lists})
    end
  end
    @query = params[:query]
  end

  def genre
    query = params[:genre]
    result = Movie.where(genre: query)
    #if page > 1 then result = Movie.where(genre: query).offset.((page*10)-10).limit(10) end
    @genre = []
    @data = [{'gen':@genres, 'lists': @lists}]
    result.each do |m|
        @genre.push({'id': m[:id],'title': m[:title], 'image': m[:image], 'year': m[:year], 'is_tv': m[:is_tv],
                            'caption': m[:title], 'rating': m[:rating]})
    end
  end

  def lists
    query = params[:list]
    @data = [{'gen':@genres, 'lists': @lists}]
    case query
    when "Top Rated"
      result = Movie.order('rating DESC').limit(100)
    when "Most Popular"
      result = Movie.where(list: 'most_pop_series').limit(100)
    when "Recent"
      result = Movie.order('year DESC').limit(100)
    when "Classic"
      result = Movie.order('year').limit(100)
    end
    @list = []
    result.each do |m|
        @list.push({'id': m[:id],'title': m[:title], 'image': m[:image], 'year': m[:year], 'is_tv': m[:is_tv],
                            'caption': m[:title], 'rating': m[:rating]})
    end
  end
  
end
