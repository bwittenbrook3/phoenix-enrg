import fetch from 'node-fetch'
import { ApolloClient } from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { HttpLink } from 'apollo-link-http';
import { onError } from 'apollo-link-error';
import { ApolloLink } from 'apollo-link';

const Client = new ApolloClient({
  connectToDevTools: process.browser,
  ssrMode: !process.browser,
  link: ApolloLink.from([
    onError(({ graphQLErrors, networkError }) => {
      if (graphQLErrors)
        graphQLErrors.map(({ message, locations, path }) =>
          console.log(
            `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`,
          ),
        );
      if (networkError) console.log(`[Network error]: ${networkError}`);
      return null;
    }),
    new HttpLink({
      uri: 'http://localhost:4000/graphql',
      fetch: fetch,
      ops: {
        credentials: 'same-origin'
      },
      headers: {
        'content-type': 'application/json',
        'accept-language': 'en_US'
      }
    })
  ]),
  cache: (process.browser
    ? new InMemoryCache().restore(window.__APOLLO_STATE__)
    : new InMemoryCache()
  )
})

export default Client