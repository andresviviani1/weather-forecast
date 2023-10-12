function WeatherCard({current, max, min, date, feelsLike, humidity, cached}) {

    return(
        <div className="flex space-between">
            <div className="flex w-96 items-center">
                <div>
                    <h1 className="text-5xl inline-block">{current}</h1>
                </div>
                <div className="pl-3">
                    <p className="text-xs">Max: {max}</p>
                    <p className="text-xs">Min: {min}</p>
                    <p className="text-xs">Humidity: {humidity}</p>
                    <p className="text-xs">Feels like: {feelsLike}</p>
                </div>
            </div>
            <div>
                <h2 className="text-right">Weather</h2>
                <p className="text-right text-xs">{date}</p>
                {cached && <p className="text-right text-xs"> Cached </p>}
            </div>

        </div>
    )
}

export default WeatherCard;