import { Query } from "react-apollo"
import gql from "graphql-tag"

const query = gql`
  {
    items {
      id
      name
    }
  }
`

export default () => (
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
)
