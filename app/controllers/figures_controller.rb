class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    if params[:title][:name] != ""
      figure.titles << Title.create(params[:title])
    end
    if params[:landmark][:name] != ""
      figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect to "/figures/#{figure.id}"
  end

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    Figure.update(params[:id], params[:figure])
    figure = Figure.find(params[:id])
    figure.landmarks.clear
    if params[:landmark][:name] != ""
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end
    figure.titles.clear
    if params[:title][:name] != ""
      figure.titles << Title.find_or_create_by(params[:title])
    end
   redirect to "/figures/#{figure.id}"
  end

end
