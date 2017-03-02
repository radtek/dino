using Gee;

using Xmpp.Core;

namespace Xmpp.Iq {

public class Stanza : Xmpp.Stanza {

    public const string TYPE_GET = "get";
    public const string TYPE_RESULT = "result";
    public const string TYPE_SET = "set";

    private Stanza(string id = UUID.generate_random_unparsed()) {
        base.outgoing(new StanzaNode.build("iq"));
        this.id = id;
    }

    public Stanza.get(StanzaNode stanza_node, string id = UUID.generate_random_unparsed()) {
        this(id);
        this.type_ = TYPE_GET;
        stanza.put_node(stanza_node);
    }

    public Stanza.result(Stanza request, StanzaNode? stanza_node = null) {
        this(request.id);
        this.type_ = TYPE_RESULT;
        if (stanza_node != null) {
            stanza.put_node(stanza_node);
        }
    }

    public Stanza.set(StanzaNode stanza_node, string id = UUID.generate_random_unparsed()) {
        this(id);
        type_ = TYPE_SET;
        stanza.put_node(stanza_node);
    }

    public Stanza.error(Stanza request, StanzaNode error_stanza, StanzaNode? associated_child = null) {
        this(request.id);
        this.type_ = TYPE_ERROR;
        stanza.put_node(error_stanza);
        if (associated_child != null) {
            stanza.put_node(associated_child);
        }
    }
    public Stanza.from_stanza(StanzaNode stanza_node, string? my_jid) {
        base.incoming(stanza_node, my_jid);
    }
}

}
