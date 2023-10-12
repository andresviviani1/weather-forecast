import Search from "./forms/Search";


function SearchBoxWrapper(){
    return <div className="grid"><div className="rounded border-solid border-px border-blue-500 bg-white p-4 place-self-center">
                <Search/>
            </div>
        </div>
}

export default SearchBoxWrapper;