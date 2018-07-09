import App, {Container} from 'next/app'
import React from 'react'
import client from '../utils/apollo-client'
import { ApolloProvider, getDataFromTree } from 'react-apollo';

const prod = process.env.NODE_ENV === 'production'

export default class CustomApp extends App {
  static async getInitialProps({Component, pageProps}) {

    let apolloState = {};
    if (!process.browser && prod) {
      // Run all graphql queries
      const app = (
        <ApolloProvider client={client}>
          <Component {...pageProps} />
        </ApolloProvider>
      );
      const data = await getDataFromTree(app)
      apolloState = client.extract()
    }

    return { apolloState }
  }

  render () {
    const {Component, pageProps, apolloState} = this.props

    // Setup apollo store rehydration
    const storeRehydration = {
        __html: `window.__APOLLO_STATE__=${JSON.stringify(apolloState).replace(/</g, '\\u003c')};`,
    }

    return <Container>
      <ApolloProvider client={client}>
        <Component {...pageProps} />
      </ApolloProvider>
      <script dangerouslySetInnerHTML={storeRehydration} />
    </Container>
  }
}
