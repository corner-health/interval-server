import { getConnectionForSocket } from '../processVars'

describe('getConnectionForSocket', () => {
  test('does not return the replacement when an older socket closes', () => {
    const closingSocket = { id: 'host-instance-id' }
    const replacementSocket = { id: closingSocket.id }
    const replacementConnection = { ws: replacementSocket }
    const connections = new Map([[replacementSocket.id, replacementConnection]])

    expect(getConnectionForSocket(connections, closingSocket)).toBeUndefined()
    expect(getConnectionForSocket(connections, replacementSocket)).toBe(
      replacementConnection
    )
  })
})
