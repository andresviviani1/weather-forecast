import SearchBoxWrapper from "../SearchBoxWrapper";

function Page() {
    return(
        <div className="bg-cover bg-center h-screen flex items-center justify-center" style={ {backgroundImage: "url('bg-image.jpg')"} }>
            <div className="container m-auto"> 
             <SearchBoxWrapper></SearchBoxWrapper>
            </div>
        </div>
    )
}

export default Page;