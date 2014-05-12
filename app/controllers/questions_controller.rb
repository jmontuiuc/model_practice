
class QuestionsController < ApplicationController
  def question_1
    # What is the most recent movie on the list that the second actor appeared in?
    @most_recent_movie_for_second_actor = Actor.second.movies.order("year DESC").first.title
  end

  def question_2
    # Who directed the longest movie on the list?

    # Your Ruby goes here.

    @director_of_longest_movie = Movie.order("duration DESC").first.director.name
  end

  def question_3
    # Which director has the most movies on the list?

    # Your Ruby goes here.

  movie_counts= {}

  Director.all.each do |the_director|
    movie_counts[the_director.name] = the_director.movies.count
  end

    @director_with_the_most_movies = movie_counts.max_by{|k,v| v}.first
  end

  def question_4
    # Which actor has been in the most movies on the list?
    # (If there's a tie, any one of them is fine)

    # Your Ruby goes here.
  actor_counts= {}

  Actor.all.each do |the_actor|
    actor_counts[the_actor.name] = the_actor.movies.count
  end

    @actor_with_the_most_movies = actor_counts.max_by{|k,v| v}.first
  end

  def question_5


    # This one is hard. Work on it after all your other review is complete.

    # Which actor/director pair has the most movies on the list?
    # (If there's a tie, any pair of them is fine)

    # Your Ruby goes here.
    # most_combo= {}
    # most_director = {}
    # Actor.all.each do |the_actor|
    #   the_actor.movies.each do |movie|
    #     most_combo =the_actor.movies.where(:director_id => movie.director_id).count
    #   end
    # end
    most_movies_together = 0
    @actor = nil
    @director = nil

    Actor.all.each do |actor|
      this_actors_most_movies_with_one_director = 0
      this_actors_favorite_director = nil

      actor.movies.each do |movie|
        number_of_movies_with_same_director_as_this_one = actor.movies.where(:director_id => movie.director_id).count

        if this_actors_most_movies_with_one_director < number_of_movies_with_same_director_as_this_one
          this_actors_most_movies_with_one_director = number_of_movies_with_same_director_as_this_one
          this_actors_favorite_director = movie.director
        end
      end

      if most_movies_together < this_actors_most_movies_with_one_director
        most_movies_together = this_actors_most_movies_with_one_director
        @director = this_actors_favorite_director
        @actor = actor
      end
    end

    @movies_together = @actor.movies.where(:director_id => @director.id)
  end
    # @actor = ???
    # @director = ???
    # @movies_together = ???

end
