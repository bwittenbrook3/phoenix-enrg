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
        return data.items.map(({ id, name }) => (
          <div key={id}>
            <p>{`${id}: ${name}`}</p>
          </div>
        ));
      }}
    </Query>
    <style jsx>{`
      .title {
        font-size: 40px;
      }
    `}</style>
  </div>
)
