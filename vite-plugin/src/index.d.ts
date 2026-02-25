import type { Plugin } from 'vite';

type RabbitaOptions = {
    main?: string;
};

/**
 * Rabbita Vite plugin.
 *
 * @param options.main Optional relative package path for selecting the
 * MoonBit main package (for example: "main" or "app/web").
 */
export declare function rabbita(options?: RabbitaOptions): Plugin;
export default rabbita;
