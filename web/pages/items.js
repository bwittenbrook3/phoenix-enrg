import { Query } from 'react-apollo'
import Nav from '../components/nav'
import gql from 'graphql-tag'

const query = gql`
  {
    items {
      id
      name
    }
  }
`

export default () => (
  <div>
    <Nav />
    <h1 className="title">Items are listed below...</h1>
    <Query query={query}>
      {({ loading, error, data }) => {
        if (loading) return <p>Loading...</p>;
        if (error) return <p>Error :()</p>;
        return <div className="items">
          {
            data.items.map(({ id, name }) => (
              <div key={id}>
                <p>{`${id}: ${name}`}</p>
              </div>
            ))
          }
        </div>
      }}
    </Query>
    <style jsx>{`
      .items{
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
      }
      .items div {
        display: block;
      }
      .title {
        font-size: 40px;
        text-align: center;
      }
    `}</style>
  </div>
)
