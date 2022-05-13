package pl.edu.agh.apdvbackend.utilities;

import com.fasterxml.jackson.databind.JsonNode;

import java.util.Iterator;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class StreamUtilities {
    public <T> Stream<T> asStream(final Iterable<T> sourceIterable) {
        return asStream(sourceIterable, false);
    }

    public <T> Stream<T> asStream(final Iterable<T> sourceIterable, boolean parallel) {
        return StreamSupport
                .stream(sourceIterable.spliterator(), parallel);
    }

    public <T> Stream<T> asStream(final Iterator<T> sourceIterator) {
        return asStream(() -> sourceIterator);
    }
}
